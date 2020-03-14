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
    private var gameLayer = GameLayer()
    
    var cameraNode: Camera!
    
    override func didMove(to view: SKView) {
        
       
       // self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.addChild(gameLayer)
        self.physicsWorld.contactDelegate = gameLayer
        
        let background = childNode(withName: "background") as! SKSpriteNode
        
        cameraNode = Camera(gameLayer.character.node, background, view.frame)
        self.addChild(cameraNode)
        self.camera = cameraNode
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


