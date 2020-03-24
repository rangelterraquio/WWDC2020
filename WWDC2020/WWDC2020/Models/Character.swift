//
//  Character.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 13/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit


class Character: SKNode{
    
    var node: SKSpriteNode!
    
    var state: State = .stopped
    
    private let maxVelocity: CGFloat = 350
    
    let initialPosition: CGPoint = CGPoint(x: -336, y: -250)
    
    var currentLevel: Level!
    
    var hasDied: Bool = false
    /**
    Init.
    - parameter shape: The shape of character.
    */
    init(_ currentLevel: Level){
        super.init()
        let light = SKLightNode()
        light.lightColor =  .white//SKColor.init(red: 255, green: 236, blue: 139, alpha: 0.5)
        light.categoryBitMask = 1
        light.shadowColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        light.falloff = 4.0
        
        light.isEnabled = true
        
        self.currentLevel = currentLevel
        node = SKSpriteNode(imageNamed: "square")
        createPhysicsShape(currentLevel)
        self.node.addChild(light)
        self.node.position = self.initialPosition
        self.addChild(node)
        self.didMoveToScene()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
     This method defines a shape the character will become.
     - parameter currentLevel: The Level indicates which shape the will become.
     */
    private func createPhysicsShape(_ currentLevl: Level){
        switch currentLevl {
        case .initialScene:
                node = SKSpriteNode(imageNamed: "square")
                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
            case .level1:
                node.lightingBitMask = 1
                node.shadowedBitMask = 1
                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                node.physicsBody?.allowsRotation = false
            case .level2:
                node.texture = SKTexture(imageNamed: "triangle")
                node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.size)
//                node.physicsBody?.friction = 1.0
            case .level3:
                node.texture = SKTexture(imageNamed: "star")
                node.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "star"), size: SKTexture(imageNamed: "star").size())
            case .level4:
                node.texture = SKTexture(imageNamed: "hexagon")
                node.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "hexagon"), size: SKTexture(imageNamed: "hexagon").size())
            case .level5:
                node.texture = SKTexture(imageNamed: "circle")
                node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width/2)
                node.physicsBody?.allowsRotation = false
            default:
                node.texture = SKTexture(imageNamed: "circle")
                node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width/2)
            }
        node.physicsBody?.friction = 0.5
        node.physicsBody?.mass = 0.1
        node.physicsBody?.categoryBitMask = PhysicsCategory.character.bitMask
        node.physicsBody?.contactTestBitMask = PhysicsCategory.collectible.bitMask | PhysicsCategory.flor.bitMask | PhysicsCategory.deathFloor.bitMask | PhysicsCategory.victoryCheckPoint.bitMask
        node.lightingBitMask = 1
        node.shadowedBitMask = 1


    }
    
    
    
    
    //MARK: -> CHARACTER MECHANICS
    
    /**
    This method defines the mechanics of rolling.
    - parameter side: which side the charecter must roll.
    */
    func rollNode(_ side: Side){
        
        guard state != .unactive, node.physicsBody != nil else {return}
        
        let velocity = node.physicsBody!.velocity.dx
//        let angularVelocity =  node.physicsBody!.angularVelocity
        let dx = side.rawValue * maxVelocity * 1.5
        
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
    
    
    func restartCheckPoint(){
        let rotation = self.node.physicsBody?.allowsRotation
        let action1 = SKAction.run {
            self.node.isHidden = true
//            self.node.physicsBody?.allowsRotation = false
//            self.node.physicsBody?.angularVelocity = 0
            self.node.physicsBody = nil

        }
        let action2 = SKAction.move(to: self.initialPosition, duration: 2)
        let action3 = SKAction.run {
            self.node.isHidden = false
//            self.node.physicsBody?.allowsRotation = rotation!
            self.createPhysicsShape(self.currentLevel)
        }
        let sequence = SKAction.sequence([action1,action2,action3])
        self.node.run(sequence)
        self.hasDied = true
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


//MARK: -> INTERACTIVE PROTOCOL

extension Character: InteractiveNode{
    
    static let characterNotification = "characterNotification"
    
    func interact() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Character.characterNotification), object: nil)
    }
    
    func didMoveToScene() -> Void {
        node.name = "Character"
        NotificationCenter.default.addObserver(self, selector: #selector(interactionCharacter), name: NSNotification.Name(rawValue: Character.characterNotification), object: nil)
    }
    
    @objc private func interactionCharacter() -> Void{

        if currentLevel == .some(.level1){
            node.removeAllChildren()
            let flashLight = FlashLight()
            flashLight.position = CGPoint(x: 80, y: 0)
            node.addChild(flashLight)
            node.zRotation = CGFloat(-90).degreesToradius()
            node.physicsBody?.allowsRotation = false
        }else if currentLevel == .some(.level2){
            node.texture = SKTexture(imageNamed: "star")
            node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.size)
            node.physicsBody?.mass = 0.1
            node.physicsBody?.categoryBitMask = PhysicsCategory.character.bitMask
            node.physicsBody?.contactTestBitMask = PhysicsCategory.collectible.bitMask | PhysicsCategory.flor.bitMask | PhysicsCategory.deathFloor.bitMask | PhysicsCategory.victoryCheckPoint.bitMask
            ///His name change to star to indicate he got the reivented power.
            node.name  = "star"
        }

       
    }
    
    
}
