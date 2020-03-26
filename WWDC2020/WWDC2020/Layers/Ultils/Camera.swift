//
//  Camera.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 13/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

public class Camera: SKCameraNode{
    
    private var screenSize: CGRect!
    private var targetNode: SKNode!
     private var referenceNode: SKSpriteNode!
    
    init(_ targetNode: SKNode, _ referenceNode: SKSpriteNode, _ screenSize: CGRect) {
        super.init()
        self.targetNode = targetNode
        self.referenceNode = referenceNode
        self.screenSize = screenSize
        self.applyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func applyConstraints(){
        
//        let minDistanceFromNode = SKRange(value: 80, variance: 30)
//
//        let nodeConstraint = SKConstraint.distance(minDistanceFromNode, to: CGPoint(x:  targetNode.position.x, y: targetNode.position.y),in: targetNode)
//
        let xRange = SKRange(lowerLimit: 0, upperLimit: referenceNode.position.x + screenSize.width/2)
        let yRange = SKRange(lowerLimit: 0, upperLimit: referenceNode.size.height - screenSize.height/2)

        let edgeContraint = SKConstraint.positionX(xRange, y: yRange)
        edgeContraint.referenceNode = referenceNode

//        self.constraints = [nodeConstraint, edgeContraint]
        let cameraRange =  SKRange(value: 80, variance: 60)
        let heroLocationConstraint = SKConstraint.distance(cameraRange, to: targetNode)
        self.constraints = [heroLocationConstraint,edgeContraint]
        
    }
    
    
    func keepCharacerInBounds() {
           
        if targetNode.position.x < -screenSize.width + (targetNode.frame.size.width + targetNode.frame.size.width/2) {
               targetNode.position.x  = -referenceNode.size.width + (targetNode.frame.size.width + targetNode.frame.size.width/2)
           }

        if targetNode.position.x  > referenceNode.size.width - targetNode.frame.size.width{
               targetNode.position.x  = referenceNode.size.width - targetNode.frame.size.width
           }
       }
   
}
