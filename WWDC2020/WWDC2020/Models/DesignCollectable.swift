//
//  DesignCollectable.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 19/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

///This class represents the collectables from Desing Level (Level 3).
public class DesignCollectable: SKSpriteNode, Collectable{
    
    static let designNotification = "designNotification"
    
    public static  var powerProgress = 0
    
    public var lifeNode: Int = 1
    
    public var observer: ObserverProtocol?

    public var id: String = ""
    override public var name: String?{
         didSet{
             self.id = name ?? ""
         }
     }
    public func didMoveToScene() {
         NotificationCenter.default.addObserver(self, selector: #selector(interactionDesign), name: NSNotification.Name(rawValue: DesignCollectable.designNotification), object: nil)
    }
    
    public func interact(with contact: SKPhysicsContact) {
        guard contact.bodyA.node?.name == self.name || contact.bodyB.node?.name == self.name else{return}
        
        lifeNode -= 1
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DesignCollectable.designNotification), object: nil)
    }
    
    @objc func interactionDesign(){
        guard let parent = self.parent as? GameScene else {return}
        if lifeNode == 0 {
            self.notifyDeathToObservers(nodeID: self.id)
            self.notifyValueObservers()
            self.removeObserver()
            self.removeFromParent()
            DesignCollectable.powerProgress += 1
        }
        
        if DesignCollectable.powerProgress == 1{
            //fazer a troca do background aqui
            parent.backgroundColor = .blue
        }else if DesignCollectable.powerProgress == 2{
            DispatchQueue.main.async {
                parent.enumerateChildNodes(withName: "bigFloor", using: { node, _ in
                    if let node = node as? SKSpriteNode{
                        node.texture = SKTexture(imageNamed: "bigFloor")
                    }
                })
            }
        }else if DesignCollectable.powerProgress == 3{
            DispatchQueue.main.async {
                parent.enumerateChildNodes(withName: "smallFloor", using: { node, _ in
                    if let node = node as? SKSpriteNode{
                        node.texture = SKTexture(imageNamed: "smallFloor")
                    }
                })
                let node = parent.childNode(withName: "EndFlag") as? SKSpriteNode
                node?.texture = SKTexture(imageNamed: "finalCheckpoint")
            }
        }
    }
    
    
}
