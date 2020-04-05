//
//  GameScene.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 13/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

//import SpriteKit
import GameplayKit

public class GameScene: SKScene {
    
   ///Instances of layers that compese the game.
    private var gameLayer: GameLayer!
    private var hudLayer: HudLayer!
    
    var cameraNode: Camera!
    
    public var currentLevel: Level!
    
    public var gameStarted: Bool = false

    ///The property difine how much progress bar must increase in each level.
    var progressBar: CGFloat = 0
    
    ///These properties are to make a movementable plataform using physics
    var platform: SKSpriteNode? = nil
    var platformSpeed: CGFloat = 150
    var platformInitialPos: CGFloat = 0
    var platformFinalPos: CGFloat = 0
    
    
    override public func didMove(to view: SKView) {
        
        gameLayer = GameLayer(level: currentLevel)
        gameLayer.zPosition = 3
        
        
        hudLayer = HudLayer(screenRect: view.frame)
        hudLayer.zPosition = 5
        setSceneHUD()
        
        gameLayer.gameState = self
        self.physicsWorld.contactDelegate = gameLayer
        self.addChild(gameLayer)

        self.backgroundColor = (currentLevel! == .level4 || currentLevel! == .level5 || currentLevel! == .finalScene ) ? NSColor(calibratedRed: 70/255, green: 29/255, blue: 82/255, alpha: 1.0) : .lightGray
        
        
        ///Setup camera
        let background = childNode(withName: "background") as? SKSpriteNode
        cameraNode = Camera(gameLayer.character.node, background ?? SKSpriteNode(color: .clear, size: view.frame.size), view.frame)
        self.addChild(cameraNode)
        self.camera = cameraNode
        self.camera?.setScale(1.3)
        cameraNode.addChild(hudLayer)
        
        
        
        addNodes(from: currentLevel)
      
        /**
           This method itarate over scene child nodes and trigger the didMoveToScene.
        */
        enumerateChildNodes(withName: "//*", using: { node, _ in
         
            if let interactiveNode = node as? InteractiveNode{
                interactiveNode.didMoveToScene()
                print("didmove")
                if let node = node as? Collectable{
                    self.gameLayer.addObservingNode(node)
                    node.addObserver(self.gameLayer)
                }
            }
            
            if self.currentLevel == .some(.level4){
                if let name = node.name, name == "movementableNode"{
                    self.gameLayer.interactableFloors.append(node as! SKSpriteNode)
                }
            }
        })
        
        /**
          verify if it's level to to add movementable plataform to the scene.
        */
        if self.currentLevel == .some(.level2){
            platformInitialPos = 1107
            platformFinalPos = 1620
            platform = SKSpriteNode(imageNamed: "plat01")
            platform?.position = CGPoint(x: platformInitialPos, y: -146)
            platform?.physicsBody = SKPhysicsBody(rectangleOf: platform!.frame.size)
            platform?.physicsBody?.affectedByGravity = false
            platform?.physicsBody?.mass = 2
            platform?.physicsBody?.allowsRotation = false
            platform?.physicsBody?.categoryBitMask = PhysicsCategory.flor.bitMask
            platform?.name = "smallFloor"
            self.addChild(platform!)
        }else if self.currentLevel == .some(.level3){
            platformInitialPos = 1890
            platformFinalPos = 3020
            platformSpeed = 170
            platform = SKSpriteNode(imageNamed: "plat01")
            platform?.position = CGPoint(x: platformInitialPos, y: -37)
            platform?.physicsBody = SKPhysicsBody(rectangleOf: platform!.frame.size)
            platform?.physicsBody?.affectedByGravity = false
            platform?.physicsBody?.mass = 2
            platform?.physicsBody?.allowsRotation = false
            platform?.physicsBody?.categoryBitMask = PhysicsCategory.flor.bitMask
            platform?.name = "smallFloor"
            self.addChild(platform!)
            
        }
        setProgressBarValue()
    }
    
    /**
    This method et the value that the progress bar should change according to the amount of collectable nodes.
    */
    private func setProgressBarValue(){
        switch self.gameLayer.nodesObserving.count {
            case 3:
                progressBar = 0.4
            case 2:
                progressBar = 0.5
            default:
                progressBar = currentLevel! != .level1 ?  1 : 0.4
        }
    }
    
    private func setSceneHUD(){
        switch gameLayer.currentGame {
            case .level1:
                    currentLevel = .level1
            case .level2:
                    currentLevel = .level2
            case .level3:
                    currentLevel = .level3
            case .level4:
                    currentLevel = .level4
            case .level5:
                    currentLevel = .level5
            default:
                    currentLevel = .finalScene
        }
    }
    
    private func movePlataform(){
        if let platform = platform, platform.physicsBody != nil{
            if(platform.position.x <= platformInitialPos && platform.physicsBody!.velocity.dx < CGFloat(0.0) ){
                
                platform.physicsBody?.velocity = CGVector(dx: platformSpeed, dy: 0.0)
                
                
            }else if((platform.position.x >= platformFinalPos) && platform.physicsBody!.velocity.dx >= 0.0){
                
                platform.physicsBody!.velocity = CGVector(dx: -platformSpeed, dy: 0.0)
                
            }else if(platform.physicsBody!.velocity.dx > 0.0){
                platform.physicsBody!.velocity = CGVector(dx: platformSpeed, dy: 0.0)
                
            }else{
                platform.physicsBody?.velocity = CGVector(dx: -platformSpeed, dy: 0.0)
                
            }
        }

    }

    //MARK: -> User Inputs
    override public func mouseDown(with event: NSEvent) {
        self.gameLayer.mouseDown(with: event)
    }
    
    override public func mouseDragged(with event: NSEvent) {
        self.gameLayer.mouseMoved(with: event)
    }
    
    override public func mouseUp(with event: NSEvent) {
        self.gameLayer.mouseUp(with: event)
    }
    
    override public func keyDown(with event: NSEvent) {
        self.gameLayer.keyDown(with: event)
    }
    
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.movePlataform()
        self.gameLayer.verifyEndGame()
               
    }
    
    
    deinit {
        self.removeAllChildren()
        self.removeAllActions()
    }
    
}




// MARK: -> GAME STATE

extension GameScene: GameState{
   
   
    /**
      This method is triggered when the game layer finishes a level to call a new one.
      
      - parameter level: The next level to be played.
      */
    class public func nextLevel(_ nextLevel: Level) -> GameScene?{
        guard let scene = GameScene(fileNamed: "Scenes/Level\(nextLevel.rawValue)") else {
            let scene = GameScene(fileNamed: "FinalScene")
            scene?.scaleMode = .aspectFill
            scene?.currentLevel = nextLevel
            return scene
        }
          scene.scaleMode = .aspectFill
          scene.currentLevel = nextLevel
          return scene
      }
    
    
    public func willStart(_ level: Level) {
        hudLayer.didMoveToScene(level)
        gameStarted = true
    }
    
    public func finished(_ level: Level) {
        print("Level\(level)")
    }
    
    public func startNewLevel() {
        guard let scene = GameScene.nextLevel(gameLayer.currentGame) else {return}
        let transiction = SKTransition.fade(withDuration: 2.5)
        view?.presentScene(scene, transition: transiction)
    }
       
    public func showMsgText() {
        hudLayer.showMsg(from: currentLevel)
    }
    
    public func showInstructionText() {
        hudLayer.showInstruction(from: currentLevel)
    }
    
    public func updatePowerProgress() {
        hudLayer.progressBar.progress += self.progressBar
    }
}

//MARK: -> ADD Interactive nodes
extension GameScene{
        
    func addNodes(from level: Level) -> Void {
        switch level {
        case .level1:
             let cbl = CBLNode(texture: SKTexture(imageNamed: "cbl"), color: .blue, size: CGSize(width: 195, height: 71))
              cbl.position = CGPoint(x: 2622.5, y: -61.47)
              cbl.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 195, height: 71))
              cbl.physicsBody?.isDynamic = false
              cbl.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
              cbl.name = "CBL"
              self.addChild(cbl)
        case .level2:
            let swift = CodeCollectable(texture: SKTexture(imageNamed: "swift"), color: .clear, size: CGSize(width: 90, height: 35))
            swift.position = CGPoint(x: 686.734, y: -86.12)
            swift.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 90, height: 35))
            swift.physicsBody?.isDynamic = false
            swift.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
            swift.name = "swift"
            self.addChild(swift)
            let xcode = CodeCollectable(texture: SKTexture(imageNamed: "xcode"), color: .clear, size: CGSize(width: 130, height: 39))
            xcode.position = CGPoint(x: 2355.7, y: -62.35)
            xcode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 130, height: 39))
            xcode.physicsBody?.isDynamic = false
            xcode.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
            xcode.name = "xcode"
            self.addChild(xcode)
            let spriteKit = CodeCollectable(texture: SKTexture(imageNamed: "spritekit"), color: .clear, size: CGSize(width: 179, height: 45))
            spriteKit.position = CGPoint(x: 3232.2, y: 297.75)
            spriteKit.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 179, height: 45))
            spriteKit.physicsBody?.isDynamic = false
            spriteKit.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
            spriteKit.name = "spriteKit"
            self.addChild(spriteKit)
        case .level3:
           let search = DesignCollectable(texture: SKTexture(imageNamed: "search"), color: .clear, size: CGSize(width: 65, height: 65))
           search.position = CGPoint(x: 634.44, y: -0.03)
           search.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 65, height: 65))
           search.physicsBody?.isDynamic = false
           search.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
           search.name = "search"
           self.addChild(search)
           let paint = DesignCollectable(texture: SKTexture(imageNamed: "paint"), color: .clear, size: CGSize(width: 60, height: 68))
           paint.position = CGPoint(x: 2788.4, y: 523.08)
           paint.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 60, height: 68))
           paint.physicsBody?.isDynamic = false
           paint.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
           paint.name = "paint"
           self.addChild(paint)
           let pen = DesignCollectable(texture: SKTexture(imageNamed: "pen"), color: .clear, size: CGSize(width: 50, height: 66))
           pen.position = CGPoint(x: 4673, y: 56.1)
           pen.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 66))
           pen.physicsBody?.isDynamic = false
           pen.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
           pen.name = "pen"
           self.addChild(pen)
        case .level4:
            let ux = UXCollectable(texture: SKTexture(imageNamed: "UX"), color: .clear, size: CGSize(width: 70, height: 70))
            ux.position = CGPoint(x: 568.8, y: -170)
            ux.alpha = 0.0
            ux.name = "uxNode"
            self.addChild(ux)
        case .level4:
            let pen = DesignCollectable(texture: SKTexture(imageNamed: "pen"), color: .clear, size: CGSize(width: 50, height: 66))
            pen.position = CGPoint(x: 4673, y: 56.1)
            pen.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 66))
            pen.physicsBody?.isDynamic = false
            pen.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
            pen.name = "pen"
            self.addChild(pen)
        case .level5:
            let timeMenage = CodeCollectable(texture: SKTexture(imageNamed: "timeMenage"), color: .clear, size: CGSize(width: 80, height: 76))
            timeMenage.position = CGPoint(x: 1364, y: 65.8)
            timeMenage.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 76))
            timeMenage.physicsBody?.isDynamic = false
            timeMenage.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
            timeMenage.name = "timeMenage"
            self.addChild(timeMenage)
            let comunication = CodeCollectable(texture: SKTexture(imageNamed: "comunication"), color: .clear, size: CGSize(width: 80, height: 80))
            comunication.position = CGPoint(x: 2414.7, y: 484)
            comunication.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 80))
            comunication.physicsBody?.isDynamic = false
            comunication.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
            comunication.name = "comunication"
            self.addChild(comunication)
            let teamWork = CodeCollectable(texture: SKTexture(imageNamed: "teamWork"), color: .clear, size: CGSize(width: 80, height: 80))
            teamWork.position = CGPoint(x: 3331, y: 1045)
            teamWork.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 80))
            teamWork.physicsBody?.isDynamic = false
            teamWork.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
            teamWork.name = "teamWork"
            self.addChild(teamWork)
            let peopleNode = PeopleNode(texture: SKTexture(imageNamed: "floor_c_1_grande"), color: .clear, size: CGSize(width: 554, height: 120))
            peopleNode.position = .zero//CGPoint(x: 2891.76, y: -444)
            peopleNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 554, height: 120))
            peopleNode.physicsBody?.isDynamic = false
            peopleNode.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
            let baseRocket = childNode(withName: "baseRocket")
            print(baseRocket)
            baseRocket?.addChild(peopleNode)
            
        default:
            print("")
        }
    }
    
}
