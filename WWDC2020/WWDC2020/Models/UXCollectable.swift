//
//  UINode.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 20/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit
///This class represents the collectables from Desing Level (Level 4).
public class UXCollectable: SKSpriteNode, Collectable{
    
    static let uiNotification = "uiNotification"
    
    public var lifeNode: Int = 1
    
    public var observer: ObserverProtocol?

    public var id: String = ""
    override public var name: String?{
         didSet{
             self.id = name ?? ""
         }
     }
    public func didMoveToScene() {
        NotificationCenter.default.addObserver(self, selector: #selector(interactionUI), name: NSNotification.Name(rawValue: UXCollectable.uiNotification), object: nil)
    }
    
    public func interact(with contact: SKPhysicsContact) {
        guard contact.bodyA.node?.name == self.name || contact.bodyB.node?.name == self.name else{return}
        
        lifeNode -= 1
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UXCollectable.uiNotification), object: nil)
    }
    
    @objc func interactionUI(){
        guard let parent = self.parent as? GameScene else {return}
        if lifeNode == 0 {
            AudioHelper.sharedInstance().playSoundEffect(music: Music.collectable)
            let zoomInAction = SKAction.scale(to: 2.5, duration: 1)
            parent.camera?.run(zoomInAction)
            self.notifyDeathToObservers(nodeID: self.id)
            self.notifyValueObservers()
            self.removeObserver()
            self.removeFromParent()
        }
        
    }
    
    
}
