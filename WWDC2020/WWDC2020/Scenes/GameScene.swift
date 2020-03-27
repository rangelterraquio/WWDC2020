//
//  GameScene.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 13/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var gameLayer: GameLayer!
    var hudLayer: HudLayer!
    var cameraNode: Camera!
    
    var currentLevel: Level!
    
    var gameStarted: Bool = false
    
    var designNode1: DesignCollectable!
    var designNode2: DesignCollectable!
    
    var progressBar: CGFloat = 0
    
    var platform: SKSpriteNode? = nil
    var platformSpeed: CGFloat = 150
    var platformInitialPos: CGFloat = 0
    var platformFinalPos: CGFloat = 0
    override func didMove(to view: SKView) {
        
        gameLayer = GameLayer(level: currentLevel)
        gameLayer.zPosition = 3
        hudLayer = HudLayer(screenRect: view.frame)
        hudLayer.zPosition = 5
       // self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        gameLayer.gameState = self
        self.addChild(gameLayer)
        self.physicsWorld.contactDelegate = gameLayer
        setSceneHUD()
        
        let background = childNode(withName: "background") as? SKSpriteNode
        
        self.backgroundColor = .lightGray
        
        
        cameraNode = Camera(gameLayer.character.node, background ?? SKSpriteNode(color: .clear, size: view.frame.size), view.frame)
        self.addChild(cameraNode)
        self.camera = cameraNode
        self.camera?.setScale(1.3)
        
        cameraNode.addChild(hudLayer)
        /**
           This method itarate over scene child nodes and trigger the didMoveToScene.
        */
        enumerateChildNodes(withName: "//*", using: { node, _ in
         
            if let interactiveNode = node as? InteractiveNode{
                interactiveNode.didMoveToScene()
                
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
            platformInitialPos = 1007
            platformFinalPos = 1620
            platform = SKSpriteNode(imageNamed: "plat01")
            platform?.position = CGPoint(x: platformInitialPos, y: -146)
            platform?.physicsBody = SKPhysicsBody(rectangleOf: platform!.frame.size)
            platform?.physicsBody?.affectedByGravity = false
            platform?.physicsBody?.mass = 2
            platform?.physicsBody?.allowsRotation = false
            platform?.physicsBody?.categoryBitMask = PhysicsCategory.flor.bitMask
            
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
//    func touchDown(atPoint pos : CGPoint) {
//        self.gameLayer.mouseDown(with: pos)
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        self.gameLayer.mouseMoved(with: pos)
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        self.gameLayer.mo
//    }
    
    override func mouseDown(with event: NSEvent) {
//        self.touchDown(atPoint: event.location(in: self))
        self.gameLayer.mouseDown(with: event)
    }
    
    override func mouseDragged(with event: NSEvent) {
//        self.touchMoved(toPoint: event.location(in: self))
        self.gameLayer.mouseMoved(with: event)
    }
    
    override func mouseUp(with event: NSEvent) {
//        self.touchUp(atPoint: event.location(in: self))
        self.gameLayer.mouseUp(with: event)
    }
    
    override func keyDown(with event: NSEvent) {
        self.gameLayer.keyDown(with: event)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //self.cameraNode.keepCharacerInBounds()
        self.movePlataform()
               
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
        guard let scene = GameScene(fileNamed: "Level\(nextLevel.rawValue)") else {
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
    
    func finished(_ level: Level) {
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
