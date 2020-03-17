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
    private let gameLayer = GameLayer()
    var hudLayer: HudLayer!
    var cameraNode: Camera!
    
    var sceneHUD: Level!
    
    override func didMove(to view: SKView) {
        
        hudLayer = HudLayer(screenRect: view.frame)
       // self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        gameLayer.gameState = self
        self.addChild(gameLayer)
        self.physicsWorld.contactDelegate = gameLayer
        
        
        setSceneHUD()
        
        let background = childNode(withName: "background") as! SKSpriteNode
        
        cameraNode = Camera(gameLayer.character.node, background, view.frame)
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        
        cameraNode.addChild(hudLayer)
        /**
           This method itarate over scene child nodes and trigger the didMoveToScene.
        */
        enumerateChildNodes(withName: "//*", using: { node, _ in
            if let interactiveNode = node as? InteractiveNode{
                interactiveNode.didMoveToScene()
            }
        })
    }
    
    private func setSceneHUD(){
        switch gameLayer.currentGame {
            case .level1:
                    sceneHUD = .level1
            case .level2:
                    sceneHUD = .level2
            case .level3:
                    sceneHUD = .level3
            case .level4:
                    sceneHUD = .level4
            case .level5:
                    sceneHUD = .level5
            default:
                    sceneHUD = .finalScene
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        self.gameLayer.keyDown(with: event)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //self.cameraNode.keepCharacerInBounds()
    }
    
    
    
    
}




// MARK: -> GAME STATE

extension GameScene: GameState{
   
   
    /**
      This method is triggered when the game layer finishes a level to call a new one.
      
      - parameter level: The next level to be played.
      */
    class public func nextLevel(_ nextLevel: Level) -> GameScene?{
          guard let scene = GameScene(fileNamed: "Level\(nextLevel)") else {return nil}
          scene.scaleMode = .aspectFill
          scene.gameLayer.currentGame = nextLevel
          return scene
      }
    
    
    func willStart(_ level: Level) {
        hudLayer.didMoveToScene(level)
    }
    
    func finished(_ level: Level) {
        print("Level\(level)")
    }
    
    func startNewLevel() {
        let scene = GameScene.nextLevel(gameLayer.currentGame)
        view?.presentScene(scene)
    }
       
    func showMsgText() {
        hudLayer.showMsg(from: sceneHUD)
    }
    
    func showInstructionText() {
        hudLayer.showInstruction(from: sceneHUD)
    }
    
    func updatePowerProgress() {
        hudLayer.progressBar.progress += 0.3
    }
}
