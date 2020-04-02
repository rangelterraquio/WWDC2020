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
    
    ///Floor who the user can interact moving them
    var interactableFloors: [SKSpriteNode] = []
    var selectedFloor: SKSpriteNode? = nil
    
    weak var gameState: GameState? = nil {
        didSet{
            gameState?.willStart(currentGame)
        }
    }
    
    var hasDied: Bool = false
    var hasFinished: Bool = false
    var isPlayAgainEnable: Bool = false
    
    
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
        self.addChild(character)
        
        enablePlayAgain()
        
    }
    func enablePlayAgain(){
        guard currentGame == .some(.finalScene) else {return}
        let wait = SKAction.wait(forDuration: 10)
        let action = SKAction.run {
            self.isPlayAgainEnable = true
        }
        self.run(SKAction.sequence([wait,action]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override public func keyDown(with event: NSEvent) {
        controlLayer.keyDown(with: event)
    }
    
    public override func mouseDown(with event: NSEvent) {
        controlLayer.mouseDown(with: event)
    }
    
    public override func mouseMoved(with event: NSEvent) {
        controlLayer.mouseMoved(with: event)
    }
    
    public override func mouseUp(with event: NSEvent) {
        controlLayer.mouseUp(with: event)
    }
    
    
    private func addUXNode(){
        let action = SKAction.run {
            if let uxNode = self.scene?.childNode(withName: "uxNode") as? UXCollectable {
                uxNode.alpha = 1
                uxNode.physicsBody = SKPhysicsBody(rectangleOf: uxNode.size)
                uxNode.physicsBody?.categoryBitMask = PhysicsCategory.collectible.bitMask
                uxNode.physicsBody?.contactTestBitMask = PhysicsCategory.collectible.bitMask
                uxNode.physicsBody?.affectedByGravity = false
                uxNode.physicsBody?.isDynamic = false
            }
        }
        let sequence = SKAction.sequence([SKAction.wait(forDuration: 2),action])
        self.run(sequence)
    }
    
    
}

//MARK: -> GAME LIFECYCLE
extension GameLayer{
    func restartCheckPoint(){
       character.restartCheckPoint()
            if currentGame == .some(.level4){
                if character.hasDied {
                    addUXNode()
                }
            }
    }
    
    func verifyEndGame(){
        if character.node.position.y <= -640{
            AudioHelper.sharedInstance().playSoundEffect(music: Music.error)
            restartCheckPoint()
        }
    }
   
    
    func finishGame(){
        
        guard !hasFinished else {return}
        
        if let particle = SKEmitterNode(fileNamed: "FinalCheckpointParticle"){
            particle.position = character.node.position
            character.addChild(particle)
        }
        let action = SKAction.run { [weak self] in
            guard let self = self else {return}
            self.character.removeAllChildren()
            self.gameState?.finished(self.currentGame)
            self.currentGame = Level.nextLevel(currentLevel: self.currentGame)
            self.gameState?.startNewLevel()
        }
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1.5),action]))
        
    }
    
    func playGameAgain(){
        if isPlayAgainEnable{
            let action = SKAction.run { [weak self] in
                guard let self = self else {return}
                self.character.removeAllChildren()
                self.gameState?.finished(self.currentGame)
                self.currentGame = Level.nextLevel(currentLevel: self.currentGame)
                self.gameState?.startNewLevel()
            }
            self.run(SKAction.sequence([SKAction.wait(forDuration: 1.5),action]))
            isPlayAgainEnable = false
        }
    }
    
}

// MARK: -> Controlable
extension GameLayer: ControlProtocol{
    
    public func mouseUnpressed(with event: NSEvent) {
        selectedFloor = nil
    }
    
    public func mousePressed(with event: NSEvent) {
        guard let parent = self.parent as? GameScene, !interactableFloors.isEmpty else {return}
        let location = parent.view!.convert(event.locationInWindow, to: parent)
        
        
        for node in interactableFloors{
            if node.contains(location){
                selectedFloor = node
            }
        }
        
        
    }
    
    public func mouseMoving(with event: NSEvent) {
        guard let node = selectedFloor, let parent = self.parent as? GameScene else {return}
        let location = parent.view!.convert(event.locationInWindow, to: parent)
        node.position = location
    }
    
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
        playGameAgain()
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
//        if node.collided(with: .deathFloor, contact: contact){
//            AudioHelper.sharedInstance().playSoundEffect(music: Music.error)
//            restartCheckPoint()
//        }
        
        /**
            This method verify if the character completed the level
         */
        if node.collided(with: .victoryCheckPoint, contact: contact){
           finishGame()
           hasFinished = true
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
