//
//  CBLNode.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 14/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit


public class CBLNode: SKSpriteNode, InteractiveNode{
    
    static let cblNotification: String = "cblNotification"
    
   
    var lifeNode = 3
    
    public func interact(with contact: SKPhysicsContact) {
        guard contact.bodyA.node?.name == self.name || contact.bodyA.node?.name == self.name else{return}
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: CBLNode.cblNotification), object: nil)
    }
    
    
    public func interact() {
       
    }
    
    public func didMoveToScene() {
        self.name = "CBLNode"
        NotificationCenter.default.addObserver(self, selector: #selector(interaction), name: NSNotification.Name(rawValue: CBLNode.cblNotification), object: nil)
    }
    
    @objc private func interaction(){
        guard lifeNode > 0 else {
            self.removeFromParent()
            return
        }
        lifeNode-=1
    }
    
   
}
