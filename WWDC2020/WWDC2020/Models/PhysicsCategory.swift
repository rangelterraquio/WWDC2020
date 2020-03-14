//
//  PhysicsCategory.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 14/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

struct PhysicsCategory {
    
    
    
    
    static let character: PhysicsCategory = PhysicsCategory(bitMask: 0b1)// 1
    static let flor: PhysicsCategory = PhysicsCategory(bitMask: 0b10)// 2
    static let collectible: PhysicsCategory = PhysicsCategory(bitMask: 0b100)// 4
    static let deathFloor: PhysicsCategory = PhysicsCategory(bitMask: 0b1000)// 8
    static let victoryCheckPoint: PhysicsCategory = PhysicsCategory(bitMask: 0b10000)//16
    
    public let bitMask: UInt32
    
    
    public func collided(with category: PhysicsCategory, contact: SKPhysicsContact) -> Bool{
        
        return (contact.bodyA.categoryBitMask == bitMask && contact.bodyB.categoryBitMask == category.bitMask) || (contact.bodyA.categoryBitMask == category.bitMask && contact.bodyB.categoryBitMask == bitMask)
        
    }
}
//
//0b1 // 1
//0b10 // 2
//0b100 // 4
//0b1000 // 8
//0b10000 // 16
//0b100000 // 32
//0b1000000 // 64
