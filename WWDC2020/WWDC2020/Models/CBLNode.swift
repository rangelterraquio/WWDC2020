//
//  CBLNode.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 14/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit


public class CBLNode: SKSpriteNode, Collectable{
    
    
    
    
    public var id: String  = {
        return "CBLNode"
    }()
    
    
    public var observer: ObserverProtocol? = nil
    
    
    static let cblNotification: String = "cblNotification"
    
   
    public var lifeNode = 3
    
    public func interact(with contact: SKPhysicsContact) {
        guard contact.bodyA.node?.name == self.name || contact.bodyA.node?.name == self.name else{return}
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: CBLNode.cblNotification), object: nil)
    }
    
    public func didMoveToScene() {
        self.name = "CBLNode"
        NotificationCenter.default.addObserver(self, selector: #selector(interactionCBL), name: NSNotification.Name(rawValue: CBLNode.cblNotification), object: nil)
    }
    //2 1
    @objc private func interactionCBL(){
        animateNode()
        guard lifeNode > 0 else {
            self.notifyDeathToObservers(nodeID: self.id)
            self.notifyValueObservers()
            self.removeAllObservers()
            self.removeFromParent()
            return
        }
        self.notifyValueObservers()
        lifeNode-=1
    }
    
    /**
    This method animate the CBL node where it has an interaction.
    */
    func animateNode(){
        let currentPosition: CGPoint = self.position
        let action1 = SKAction.moveTo(y: currentPosition.y + 20, duration: 0.10)
        let action2 = SKAction.moveTo(y: currentPosition.y, duration: 0.1)
        let actionMode = SKActionTimingMode.easeInEaseOut
        let sequence = SKAction.sequence([action1,action2])
        sequence.timingMode = actionMode
        self.run(sequence)
        addParticle()
    }
    
    func addParticle(){
        if let particle = SKEmitterNode(fileNamed: "CBLParticle"){
            switch lifeNode {
                case 2:
                    particle.particleTexture = SKTexture(imageNamed: "Investigete")
                case 1:
                    particle.particleTexture = SKTexture(imageNamed: "Act")
                default:
                    particle.particleTexture = SKTexture(imageNamed: "Engage")
            }
            self.addChild(particle)
        }
    }
   
}


