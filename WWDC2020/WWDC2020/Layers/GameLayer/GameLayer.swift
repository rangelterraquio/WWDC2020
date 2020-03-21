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
    
    var character: Character!
    let controlLayer = ControlLayer()
    var currentGame: Level!
    
    var numCollectable = 0
    
    var gameState: GameState? = nil {
        didSet{
            gameState?.willStart(currentGame)
        }
    }
    
    //Proporty from Observer Protocol.
    public var nodesObserving: [ObservableProtocol] = [] {
           didSet{
            if nodesObserving.isEmpty && (gameState?.gameStarted ?? false) {
                gameState?.showMsgText()
                character.interact()
                if let wallNode = scene?.childNode(withName: "wallShape") as? InteractiveNode{
                    wallNode.interact?()
                }
            }
           }
    }
     public init(level: Level) {
        super.init()
        self.currentGame = level
        controlLayer.controlable = self
        character = Character(level)
        //self.addChild(character.node)
        self.addChild(character)
        
        
       
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
        
            
            if let nodeA = contact.bodyA.node as? InteractiveNode{
                nodeA.interact?(with: contact)
            }else if let nodeB = contact.bodyB.node as? InteractiveNode{
                nodeB.interact?(with: contact)
            }
            
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




extension GameLayer: ObserverProtocol{
   
    
   
    
    public var id: String {
        get {
            return self.name ?? ""
        }
        set {
             self.name = "gameLayer"
        }
    }
    
    public func onValueChanged() {
        self.gameState?.updatePowerProgress()
    }
    
    public func observableNodeHasDied(nodeID: String) {
        self.removeObservingNode(nodeID)
    }
    
    
}
