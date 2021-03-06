//
//  ProgressBar.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 16/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

public class ProgressBar: SKNode {
    
    
    private var screenSize: CGRect!
    
    //Graphic compentes of progressBar
    private var background: SKSpriteNode!
    private var bar: SKSpriteNode!
    
    ///A clousure to trigger a action when the progress is completed
    var progressCompleted: (() -> ())?
    
    public var progress:CGFloat = 1{
        didSet{
            let value = max(min(progress,1.0),0.0)
            if let bar = bar {
                bar.xScale = value
                
            }
            if progress >= 1 {
                if let function = progressCompleted{
                    function()
                }
                progress = 0
                bar.xScale = 0
            }
        }
    }
    
    public init(textureBackground: String, textureBar: String, screenRect: CGRect){
        super.init()
        self.screenSize = screenRect
        background = SKSpriteNode(imageNamed: textureBackground)
        bar = SKSpriteNode(imageNamed: textureBar)
        background.position = CGPoint(x: -25, y: 0)
        bar.zPosition = 1.0
        bar.position = CGPoint(x:-94,y:0)//
        bar.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.addChild(background)
        self.addChild(bar)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
