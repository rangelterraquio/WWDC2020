//
//  FlashLight.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 19/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

class FlashLight: SKLightNode {
    
    let top = SKSpriteNode(color: .clear, size: CGSize(width: 10000, height: 5))
    let bottom = SKSpriteNode(color: .clear, size: CGSize(width: 10000, height: 5))
    let back = SKSpriteNode(color: .clear, size: CGSize(width: 50, height: 5))
    let spritePhiscsBody = SKSpriteNode(imageNamed: "luz")
    var falloffValue: CGFloat = 0.5
    let effectflash = SKSpriteNode(color: .yellow, size: CGSize(width: 1.0, height: 100))
    let lightEffect  = SKShapeNode()
    override init() {
        super.init()
        
        //MARK:if para fallof
//        self.falloff = 0.3
        //255 236 139
        //self.ambientColor = SKColor.init(red: 0, green: 0, blue: 0.0, alpha: 0.5)
        self.lightColor =  .white//SKColor.init(red: 255, green: 236, blue: 139, alpha: 0.5)
        self.categoryBitMask = 1
        self.shadowColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.8)
       // self.isEnabled = true
        self.falloff = 0.3
        
        top.zRotation = -1.2
        top.position = CGPoint(x: self.back.size.width/2, y: 0)
        top.anchorPoint = CGPoint(x: 0, y: 0.5)
        top.shadowCastBitMask = 1
        top.lightingBitMask = 1
        top.zPosition = -1
        back.addChild(top)
        
        bottom.zRotation = 1.2
        bottom.position = CGPoint(x: -self.top.position.x, y: 0)
        bottom.anchorPoint = CGPoint(x: 1, y: 0.5)
        bottom.shadowCastBitMask = 1
        bottom.lightingBitMask = 1
        bottom.zPosition = -1
        back.addChild(bottom)
        
        back.position = CGPoint(x: -60, y: self.frame.height/2)
        back.zRotation = CGFloat.pi/2
        back.shadowCastBitMask = 1
        back.lightingBitMask = 1
        back.zPosition = -1
        self.addChild(back)
        
        spritePhiscsBody.texture = SKTexture(imageNamed: "luz")
        spritePhiscsBody.size = CGSize(width: spritePhiscsBody.frame.width + 1600, height: spritePhiscsBody.frame.height + 1000)
        spritePhiscsBody.alpha = 0.0
        spritePhiscsBody.position = CGPoint(x: 1450, y: 280)
        self.addChild(spritePhiscsBody)

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

