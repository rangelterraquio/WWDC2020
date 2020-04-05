//
//  PeopleNode.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 21/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

public class PeopleNode: SKSpriteNode, InteractiveNode{
    
    
       static let peopleNotification = "peopleNotification"
         
       public override init(texture: SKTexture?, color: NSColor, size: CGSize) {
             super.init(texture: texture, color: color, size: size)
         }
       
       public required init?(coder aDecoder: NSCoder) {
           fatalError("fatal error")
       }
    
       public func interact(with contact: SKPhysicsContact?) {

           guard contact?.bodyA.node?.name == self.name || contact?.bodyB.node?.name == self.name else{return}
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: PeopleNode.peopleNotification), object: nil)
       }
       
       public func didMoveToScene() {
           NotificationCenter.default.addObserver(self, selector: #selector(interactionPeople), name: NSNotification.Name(rawValue: PeopleNode.peopleNotification), object: nil)
       }
       
       @objc private func interactionPeople(){
        
            AudioHelper.sharedInstance().playBackgroundMusic(music: Music.jetpack)
            let action = SKAction.moveTo(y: 902, duration: 6.5)
        
        let actionFim = SKAction.run{
            
            AudioHelper.sharedInstance().pauseBackgroundMusic()
        }
        if let baseRocket = self.parent{
            baseRocket.run(SKAction.sequence([action,actionFim]))

        }
        

       }
    
    
}
