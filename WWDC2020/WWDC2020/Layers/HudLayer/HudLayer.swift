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
    private lazy var fadeIn    =        SKAction.fadeIn(withDuration: 0.8)
    private lazy var fadeOut   =        SKAction.fadeOut(withDuration: 0.8)
    private lazy var waitThree =        SKAction.wait(forDuration: 3.5)
    private lazy var waitTwo   =        SKAction.wait(forDuration: 2.0)
    private lazy var showProgressBar =  SKAction.run {  [weak self] in
        guard let self = self else {return}
        self.instructionNode.alpha = 0.0
        self.barTitle.run(self.fadeIn)
        self.progressBar.run(self.fadeIn)
    }
    

    private let msgNode = SKLabelNode()
    private let instructionNode = SKLabelNode()
    
    ///A graphic progress Bar with title label
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
        instructionNode.fontColor = .green
        instructionNode.colorBlendFactor = 1.0
        instructionNode.position = CGPoint(x: 0, y: screenSize.height * 0.4)
        self.addChild(instructionNode)
        
        progressBar.progress = 0.0
        progressBar.progressCompleted = { [weak self] in
            guard let self = self else {return}
            self.progressBar.isHidden = true
            self.barTitle.isHidden = true
        }
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
    
    /**
    This method is perform an action to show msgLabel.
    
    - parameter level: The message related to that level.
    */
    func showMsg(from level: Level) -> Void {

        msgNode.text = level.elements.msgText
        instructionNode.text = level.elements.instructionText
        let lastAction = SKAction.run { [weak self] in
            self?.showInstruction(from: level)
        }
        let sequence = SKAction.sequence([fadeIn,waitThree,fadeOut,lastAction])
        msgNode.run(sequence)
        
        
    }
    /**
      This method is perform an action to show InstructionLabel.
      
      - parameter level: The instruction related to that level.
      */
    func showInstruction(from level: Level) -> Void {
        instructionNode.text = level.elements.instructionText
        let sequence = SKAction.sequence([fadeIn,waitThree,fadeOut])
        instructionNode.run(sequence)
           
    }
    
    /**
      This method is trigged an when the scene is loaded.
      
      - parameter level: The current level.
      */
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
                let sequence = SKAction.sequence([waitTwo, fadeIn,waitThree,fadeOut, changeInstruction,fadeIn, waitThree, fadeOut,changeInstruction2,fadeIn, waitThree, fadeOut, showProgressBar])
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
                return Element(msgText: "You != User, now with UX power things makes sense to the user", instructionText: "Drag the floors using the mouse to move ahead")
            case .level5:
                return Element(msgText: "You got UX power, now you things makes sense to the user", instructionText: "Drag the floors to move ahead")
            default:
                return Element(msgText: "", instructionText: "")
        }
    }
}
