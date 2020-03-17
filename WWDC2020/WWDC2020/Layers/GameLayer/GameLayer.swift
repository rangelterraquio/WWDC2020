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
    let controlLayer = ControlLayer()
    var currentGame: Level = .level1
    
    var powerProgress = 0
    
    var gameState: GameState? = nil {
        didSet{
            gameState?.willStart(.level1)
        }
    }
    
    override public init() {
        super.init()
        
        controlLayer.controlable = self
        character = Character(.star)
        self.addChild(character.node)
        

    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override public func keyDown(with event: NSEvent) {
        controlLayer.keyDown(with: event)
    }
    
}

//MARK: -> GAME LIFECYCLE
extension GameLayer{
    func restartCheckPoint(){
        character.node.position = character.initialPosition
        if let camera = (self.parent as! GameScene).camera{
            camera.position = character.initialPosition
        }
    }
    
    func finishGame(){
        gameState?.finished(currentGame)
        currentGame = Level.nextLevel(currentLevel: currentGame)
        gameState?.startNewLevel()
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
            guard let scene = self.parent as? GameScene else{return}
            
            var powerProgress = 0
            /**
               This method itarate over scene child nodes and trigger the interaction.
            */
            scene.enumerateChildNodes(withName: "//*", using: {node, _ in
                if let interactiveNode = node as? InteractiveNode{
                    interactiveNode.interact(with: contact)
                    
                    self.gameState?.updatePowerProgress()
                    ///this line check if there are still collectibles in the scene to updete the HUD.
                    powerProgress += node.parent == nil ? 1 : 0
                }
            })
            
            ///Updete the HUD.
            powerProgress != 0 ? gameState?.showMsgText() : print("Update Graphic")
        }
        
        /**
            This method verify if the character collided with the deathFloor
         */
        if node.collided(with: .deathFloor, contact: contact){
            
            restartCheckPoint()
        }
        
        /**
            This method verify if the character completed the level
         */
        if node.collided(with: .victoryCheckPoint, contact: contact){
            
           finishGame()
        }

    }
}
