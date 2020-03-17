//
//  HudLayer.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 15/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

public class HudLayer: SKNode{
    
    var screenSize: CGRect!
    /**
        Actions to animete the hud elements.
     */
    private lazy var fadeIn   =        SKAction.fadeIn(withDuration: 0.8)
    private lazy var fadeOut  =        SKAction.fadeOut(withDuration: 0.8)
    private lazy var waitFive =        SKAction.wait(forDuration: 5.0)
    private lazy var waitTwo  =        SKAction.wait(forDuration: 2.0)
    private lazy var showProgressBar = SKAction.run {  [weak self] in
        guard let self = self else {return}
        self.barTitle.run(self.fadeIn)
        self.progressBar.run(self.fadeIn)
    }
    
    private let msgNode = SKLabelNode()
    private let instructionNode = SKLabelNode()
    
    var progressBar: ProgressBar!
    private let barTitle = SKLabelNode(text: "Learning Progress")
    
     public init(screenRect: CGRect) {
        super.init()
        
        progressBar = ProgressBar(textureBackground: "bgBar", textureBar: "bar", screenRect: screenRect)
        self.screenSize = screenRect
        msgNode.fontSize = 30
        msgNode.fontColor = .green
        msgNode.colorBlendFactor = 1.0
        msgNode.position = CGPoint(x: 0, y: screenSize.height * 0.4)
        self.addChild(msgNode)
        
        instructionNode.fontSize = 35
        instructionNode.fontColor = .black
        instructionNode.colorBlendFactor = 1.0
        instructionNode.position = CGPoint(x: 0, y: screenSize.height * 0.4)
        self.addChild(instructionNode)
        
        progressBar.progress = 0.0
        progressBar.position = CGPoint(x: 0, y: screenSize.height * 0.45)
        progressBar.zRotation = CGFloat(90).degreesToradius()
        progressBar.alpha = 0.0
        self.addChild(progressBar)
        
        barTitle.fontSize = 20
        barTitle.color = .blue
        barTitle.colorBlendFactor = 1.0
        barTitle.position = CGPoint(x: 0, y: screenSize.height * 0.46)
        barTitle.alpha = 0.0
        self.addChild(barTitle)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showMsg(from level: Level) -> Void {

        msgNode.text = level.elements.msgText
        let sequence = SKAction.sequence([fadeIn,waitFive,fadeOut])
        msgNode.run(sequence)
        
    }
    
    func showInstruction(from level: Level) -> Void {
        instructionNode.text = level.elements.instructionText
        let sequence = SKAction.sequence([fadeIn,waitFive,fadeOut])
        instructionNode.run(sequence)
           
    }
    
    
    func didMoveToScene(_ level: Level){
        
        switch level {
        case .initialScene:
            print("initial Scene")
        case .finalScene:
            print("Final scene")
        case .level1:
            instructionNode.text = "Use left and right arrow to roll sideways"
            let changeInstruction = SKAction.run {[weak self] in
                guard let self = self else {return}
                self.instructionNode.text = "Use space to jump"
            }
            let changeInstruction2 = SKAction.run {[weak self] in
                guard let self = self else {return}
                self.instructionNode.text = "Collect Itens to learn and got new skills"
            }
            let sequence = SKAction.sequence([waitTwo, fadeIn,waitFive,fadeOut, changeInstruction,fadeIn, waitFive, fadeOut,changeInstruction2,fadeIn, waitFive, fadeOut, showProgressBar])
            instructionNode.run(sequence)
        default:
            self.run(SKAction.sequence([waitTwo,showProgressBar]))
        }
    }
    
    
}


protocol SceneHUD{
    
    var msgText: String {get}
    var instructionText: String {get}
    
}

///This  extesion defines all hud elements each scene will have.
extension Level{
    struct Element: SceneHUD {
        var msgText: String
        var instructionText: String
    }
    var elements: Element{
        switch self {
            case .initialScene:
                return Element(msgText: "", instructionText: "")
            case .level1:
                return Element(msgText: "You got CBL power, now you are able to see things more clearly", instructionText: "Intercte with object to get super powers")
            case .level2:
                return Element(msgText: "You got the power to reinvent yourself", instructionText: "Use the R to reinvent yourself")
            case .level3:
                return Element(msgText: "", instructionText: "")
            case .level4:
                return Element(msgText: "", instructionText: "")
            case .level5:
                return Element(msgText: "", instructionText: "")
            default:
                return Element(msgText: "", instructionText: "")
        }
    }
}
