//
//  WallShapeNode.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 17/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

public class  WallShapeNode: SKSpriteNode, InteractiveNode{
    
    static let  wallNotification = "WallShapeNode"

    
    public func interact() {
        ///I verify if the contact it's between itself and a node called "star"
//        guard (contact.bodyA.node?.name == self.name || contact.bodyA.node?.name == self.name) && (contact.bodyA.node?.name == "star" || contact.bodyB.node?.name == "star") else{return}
//        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: WallShapeNode.wallNotification), object: nil)
    }
    
   
    
    public func didMoveToScene() {
        self.name = "wallShape"
        NotificationCenter.default.addObserver(self, selector: #selector(interactionWall), name: NSNotification.Name(rawValue: WallShapeNode.wallNotification), object: nil)
    }
    
    @objc private func interactionWall(){
        self.removeFromParent()
    }
    
    
    
}
