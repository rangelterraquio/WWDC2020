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
    
   
    public var lifeNode = 2
    
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
    
   
}
