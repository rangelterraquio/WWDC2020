//
//  CodeCollectable.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 17/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

///This class represents the collectables from Code Level (Level 2).
public class CodeCollectable: SKSpriteNode, Collectable{
    
    
    
    public var id: String = ""

    override public var name: String?{
        didSet{
            self.id = name ?? ""
        }
    }
    public var observer: ObserverProtocol? = nil
    
    
    public var lifeNode: Int = 1
 
    static let codeNotification = "codeNotification"
   
    
    public func interact(with contact: SKPhysicsContact) {

        guard contact.bodyA.node?.name == self.name || contact.bodyB.node?.name == self.name else{return}
        
        lifeNode -= 1
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: CodeCollectable.codeNotification), object: nil)
    }
    
    public func didMoveToScene() {
        NotificationCenter.default.addObserver(self, selector: #selector(interactionCode), name: NSNotification.Name(rawValue: CodeCollectable.codeNotification), object: nil)
    }
    
    @objc private func interactionCode(){
        if lifeNode == 0 {
            AudioHelper.sharedInstance().playSoundEffect(music: Music.collectable)
            self.notifyDeathToObservers(nodeID: self.id)
            self.notifyValueObservers()
            self.removeObserver()
            self.removeFromParent()
        }
    }
    
    
    
}
