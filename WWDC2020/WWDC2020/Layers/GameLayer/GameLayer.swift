//
//  GameLayer.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 13/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

public class GameLayer: SKNode{
    
    var character = Character(.square)
    var controlLayer = ControlLayer()
    override public init() {
        super.init()
        
        controlLayer.controlable = self
        character = Character(.square)
        self.addChild(character.node)
        
        
    
    }
    
    func restartCheckPoint(){
        character.node.position = character.initialPosition
        if let camera = (self.parent as! GameScene).camera{
            camera.position = character.initialPosition 
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override public func keyDown(with event: NSEvent) {
        controlLayer.keyDown(with: event)
    }
    
}

// MARK: -> Controlable
extension GameLayer: ControlProtocol{
    
    public func leftArrowPressed() {
        character.rollNode(.left)
    }
    
    public func rightArrowPressed() {
        character.rollNode(.right)
    }
    
    public func leftArrowUnpressed() {
        character.stopRolling()
    }
    
    public func rightArrowUnpressed() {
        character.stopRolling()

    }
    
    public func aKeyPressed() {
        character.stopRolling()

    }
    
    public func wKeyPressed() {
        character.stopRolling()
    }
    
    public func dKeyPressed() {
         character.stopRolling()
    }
    
    public func sKeyPressed() {
        character.stopRolling()
    }
    
    public func spacePressed() {
        character.jump()
    }
}


extension GameLayer: SKPhysicsContactDelegate{
    
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        let node = PhysicsCategory.character
        
        /**
            This method verify if the character collided with the floor  and change his state
         */
        if node.collided(with: .flor, contact: contact){
            character.fall()
        }
        
        /**
            This method verify if the character collided with the collectible
         */
        if node.collided(with: .collectible, contact: contact){
            
        }
        
        /**
            This method verify if the character collided with the deathFloor
         */
        if node.collided(with: .deathFloor, contact: contact){
            
            restartCheckPoint()
        }
        
        
    }
}