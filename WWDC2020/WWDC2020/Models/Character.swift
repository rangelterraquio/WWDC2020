//
//  Character.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 13/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit


class Character{
    
    var node: SKShapeNode!
    
    var state: State = .stopped
    
    private let maxVelocity: CGFloat = 350
    
    let initialPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    init(_ shape: CharacterShape){
        createNodeShape(shape)
        
    }
    
    
    /**
     This method defines a shape the character will become.
     - parameter shape: The shape of character.
     */
    private func createNodeShape(_ shape: CharacterShape){
        switch shape {
        case .square:
            node = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
            node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
            node.fillColor = .red
        default:
            node = SKShapeNode(circleOfRadius: 25)
            node.physicsBody = SKPhysicsBody(circleOfRadius: 25)

            node.fillColor = .red
        }
        node.physicsBody?.mass = 0.1
        node.physicsBody?.categoryBitMask = PhysicsCategory.character.bitMask
        node.physicsBody?.contactTestBitMask = PhysicsCategory.collectible.bitMask | PhysicsCategory.flor.bitMask | PhysicsCategory.deathFloor.bitMask | PhysicsCategory.victoryCheckPoint.bitMask
//        node.physicsBody?.friction = 1.0
        node.physicsBody?.isDynamic = true
    }
    
    
    func rollNode(_ side: Side){
        
        guard state != .unactive else {return}
        
        let velocity = node.physicsBody!.velocity.dx
//        let angularVelocity =  node.physicsBody!.angularVelocity
        let dx = side.rawValue * maxVelocity
        
        if abs(velocity) < maxVelocity{
//        if abs(angularVelocity) < 3{
//            print(abs(angularVelocity))
            node.physicsBody?.applyForce(CGVector(dx: dx, dy: 0.0))
//        node.physicsBody?.applyTorque(-(3  * side.rawValue))
//            node.physicsBody?.applyForce(CGVector(dx: dx, dy: 0.0), at: CGPoint(x: node.frame.width/2, y: node.frame.height))
        }
        state = .rolling
    }
    
    func stopRolling(){
        guard state != .jumping, state != .unactive else {return}
        state = .stopped
    }
    
    func jump(){
        guard state != .jumping, state != .unactive else {return}
        
        node.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 70))
        
       state = .jumping
    }
    
    func fall(){
        guard state != .rolling, state != .unactive else {return}
        state = .stopped
    }
    
}

/**
 This enum defines all shapes the character can assume.
 */
enum CharacterShape{
    case triangle
    case square
    case star
    case hexagon
    case circle
}

/**
 This enum defines all states the character can assume.
 */
enum State{
    case rolling
    case falling
    case jumping
    case stopped
    case unactive
}
