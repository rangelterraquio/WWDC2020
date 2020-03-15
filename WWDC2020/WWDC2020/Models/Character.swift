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
    
    /**
    Init.
    - parameter shape: The shape of character.
    */
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
        case .triangle:
            node = SKShapeNode(path: createTriangle())
            node.physicsBody = SKPhysicsBody(polygonFrom: createTriangle())
            node.fillColor = .red
        case .star:
            node = SKShapeNode(path: createStar())
            node.physicsBody = SKPhysicsBody(polygonFrom: createStar())
            node.fillColor = .red
        case .hexagon:
            node = SKShapeNode(path: createHexagon())
            node.physicsBody = SKPhysicsBody(polygonFrom: createHexagon())
            node.fillColor = .red
        default:
            node = SKShapeNode(circleOfRadius: 25)
            node.physicsBody = SKPhysicsBody(circleOfRadius: 25)
            node.fillColor = .red
        }
        node.physicsBody?.mass = 0.1
        node.physicsBody?.categoryBitMask = PhysicsCategory.character.bitMask
        node.physicsBody?.contactTestBitMask = PhysicsCategory.collectible.bitMask | PhysicsCategory.flor.bitMask | PhysicsCategory.deathFloor.bitMask | PhysicsCategory.victoryCheckPoint.bitMask

    }
    
    
    
    //MARK: -> CHARACTER MECHANICS
    
    /**
    This method defines the mechanics of rolling.
    - parameter side: which side the charecter must roll.
    */
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
    
    
    /**
    This method makes the character stop rolling.
    */
    func stopRolling(){
        guard state != .jumping, state != .unactive else {return}
        state = .stopped
    }
    
    /**
    This method makes the character jumping.
    */
    func jump(){
        guard state != .jumping, state != .unactive else {return}
        
        node.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 70))
        
       state = .jumping
    }
    
    /**
    This method verify if the character fall.
    */
    func fall(){
        guard state != .rolling, state != .unactive else {return}
        state = .stopped
    }
    
}

//MARK: -> SHAPES
extension Character{
    
    private func createTriangle() -> CGMutablePath{
        let height: CGFloat = 50
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: height/2, y: (height/2)*sqrt(3)))
        path.addLine(to: CGPoint(x: height, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        return path
    }
    
    private func createStar() -> CGMutablePath{
        let starPath = CGMutablePath()
        starPath.move(to: CGPoint(x: 117.5, y: 60.5))
        starPath.addLine(to: CGPoint(x: 126.32, y: 73.36))
        starPath.addLine(to: CGPoint(x: 141.28, y: 77.77))
        starPath.addLine(to: CGPoint(x: 131.77, y: 90.14))
        starPath.addLine(to: CGPoint(x: 132.19, y: 105.73))
        starPath.addLine(to: CGPoint(x: 117.5, y: 100.5))
        starPath.addLine(to: CGPoint(x: 102.81, y: 105.73))
        starPath.addLine(to: CGPoint(x: 103.23, y: 90.14))
        starPath.addLine(to: CGPoint(x: 93.72, y: 77.77))
        starPath.addLine(to: CGPoint(x: 108.68, y: 73.36))

        return starPath

    }
    
    private func createHexagon() -> CGMutablePath{
        let polygonPath = CGMutablePath()
        polygonPath.move(to: CGPoint(x: 108, y: 111))
        polygonPath.addLine(to: CGPoint(x: 131.78, y: 128.27))
        polygonPath.addLine(to: CGPoint(x: 122.69, y: 156.23))
        polygonPath.addLine(to: CGPoint(x: 93.31, y: 156.23))
        polygonPath.addLine(to: CGPoint(x: 84.22, y: 128.27))
        return polygonPath
    }
}

/**
 This enum defines all shapes the character can assume.
 */
public enum CharacterShape{
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
