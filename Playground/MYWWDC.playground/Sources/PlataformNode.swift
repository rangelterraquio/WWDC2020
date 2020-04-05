//
//  PlataformNode.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 22/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

class PlataformNode: SKSpriteNode, InteractiveNode{
    
    
       static let plataformNotification = "plataformNotification"
      
       
       public func interact(with contact: SKPhysicsContact?) {

           guard contact?.bodyA.node?.name == self.name || contact?.bodyB.node?.name == self.name else{return}
            
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PlataformNode.plataformNotification), object: nil)
       }
       
       public func didMoveToScene() {
        
        print("Hellooo")
           //NotificationCenter.default.addObserver(self, selector: #selector(interactionPeople), name: NSNotification.Name(rawValue: PeopleNode.peopleNotification), object: nil)
//        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
//        self.physicsBody?.affectedByGravity = false
//        self.physicsBody?.mass = 2
       // while(true){
//            while self.position.x < 1560{
//                if abs(self.physicsBody!.velocity.dx) <= CGFloat(40.0){
//                    self.physicsBody?.applyForce(CGVector(dx: 40, dy: 0))
//                }
//            }
//            while self.position.x > 1260{
//                if abs(self.physicsBody!.velocity.dx) <= CGFloat(40.0){
//                    self.physicsBody?.applyForce(CGVector(dx: -40, dy: 0))
//                }
//            }
       // }
 
        
//        let action1 = SKAction.run {
//            while self.position.x < 1560{
//                    if abs(self.physicsBody!.velocity.dx) <= CGFloat(40.0){
//                        self.physicsBody?.applyForce(CGVector(dx: 40, dy: 0))
//                    }
//                }
//        }
//        let action2 = SKAction.run {
//             while self.position.x > 1260{
//                    if abs(self.physicsBody!.velocity.dx) <= CGFloat(40.0){
//                        self.physicsBody?.applyForce(CGVector(dx: -40, dy: 0))
//                    }
//                }
//        }
//        let sequence = SKAction.sequence([SKAction.wait(forDuration: 5), action1,action2])
//        self.run(SKAction.repeatForever(sequence))
        
       }
    
    
    
    
    
    
    
}
