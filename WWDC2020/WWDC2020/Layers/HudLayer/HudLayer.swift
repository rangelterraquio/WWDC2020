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
        
    

        self.screenSize = screenRect
        msgNode.fontSize = 25
        msgNode.colorBlendFactor = 1.0
        msgNode.position = CGPoint(x: 0, y: screenSize.height * 0.4)
        msgNode.fontName = "Cascadia Code"
        self.addChild(msgNode)
        
        instructionNode.fontSize = 25
        instructionNode.colorBlendFactor = 1.0
        instructionNode.position = CGPoint(x: 0, y: screenSize.height * 0.4)
        instructionNode.fontName = "Cascadia Code"
        self.addChild(instructionNode)
        
        
        
        barTitle.fontSize = 15
        barTitle.colorBlendFactor = 1.0
        barTitle.position = CGPoint(x: 0, y: screenSize.height * 0.38)
        barTitle.alpha = 0.0
        barTitle.horizontalAlignmentMode = .center
        barTitle.verticalAlignmentMode = .center
        barTitle.fontName = "Cascadia Code"
        self.addChild(barTitle)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
    This method is define a color for the SKLabelNode.
    
    - parameter level: The color related to that level.
    */
    private func setupColor(from level: Level) -> NSColor{
        switch level {
        case .level1:
            return .white
        case .level2:
            return .black
        case .level3:
            return .black
        default:
            return NSColor(calibratedRed: 110/255, green: 240/255, blue: 252/255, alpha: 1.0)//.yellow
        }
    }
    /**
    This method is define a font for the SKLabelNode.
    
    - parameter level: The fontname related to that level.
    */
    private func setupFont(from level: Level) -> String{
        switch level {
        case .level1:
            return "Marker Twins"
        case .level2:
            return "Marker Twins"
        case .level3:
            return "Marker Twins"
        default:
            return "Cascadia Code"
        }
    }
    /**
    This method is setup the progressBar.
    
    - parameter level: ProgressBar is defined by the level.
    */
    private func setupProgressBar(from level: Level) -> Void{
        if level == .level4 || level == .level5{
            progressBar = ProgressBar(textureBackground: "bkBar_c", textureBar: "frontBar_c", screenRect: self.screenSize)
        }else{
            progressBar = ProgressBar(textureBackground: "bgBar", textureBar: "frontBar", screenRect: self.screenSize)
        }
        
        progressBar.progress = 0.0
        progressBar.progressCompleted = { [weak self] in
            guard let self = self else {return}
            self.progressBar.isHidden = true
            self.barTitle.isHidden = true
        }
        progressBar.position = CGPoint(x: screenSize.width * 0.0232, y: screenSize.height * 0.35)
        progressBar.alpha = 0.0
        self.addChild(progressBar)
    }
    
    /**
    This method is perform an action to show msgLabel.
    
    - parameter level: The message related to that level.
    */
    public func showMsg(from level: Level) -> Void {
        msgNode.numberOfLines = level == .some(.level5) ? 2 : 1
        msgNode.verticalAlignmentMode = .center
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
    public func showInstruction(from level: Level) -> Void {
        instructionNode.text = level.elements.instructionText
        let sequence = SKAction.sequence([fadeIn,waitThree,fadeOut])
        instructionNode.run(sequence)
           
    }
    
    public func blinkInstructionLabel(){
           let action = SKAction.fadeAlpha(to: 0.2, duration: 0.7)
           let action2 = SKAction.fadeAlpha(to: 1.0, duration: 0.7)
           let sequence = SKAction.sequence([action,action2])
           instructionNode.run(SKAction.repeatForever(sequence), withKey: "blink")
       }
    /**
      This method is trigged an when the scene is loaded.
      
      - parameter level: The current level.
      */
    public func didMoveToScene(_ level: Level){
        setupProgressBar(from: level)
        let color = setupColor(from: level)
        barTitle.fontColor = color
        msgNode.fontColor = color
        instructionNode.fontColor = color
        barTitle.fontName = setupFont(from: level)
        msgNode.fontName = setupFont(from: level)
        instructionNode.fontName = setupFont(from: level)
        switch level {
            case .initialScene:
                print("initial Scene")
            case .finalScene:
            print("")
            msgNode.text = "OUR first app journey.\n\n\nThank you."
            let action2 = SKAction.run{
                self.instructionNode.text = "Press space to play again."
                self.instructionNode.position = CGPoint(x: 0, y: self.screenSize.height * 0.25)
                self.instructionNode.run(self.fadeIn)
                self.blinkInstructionLabel()
            }
            let sequence = SKAction.sequence([waitTwo, fadeIn,SKAction.wait(forDuration: 10),action2])
            msgNode.run(sequence)
            case .level1:
                instructionNode.text = "Use left and right arrow to roll sideways"
                let changeInstruction = SKAction.run {    
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


public protocol SceneHUD{
    
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
                return Element(msgText: "You got the power to reinvent yourself", instructionText: "")
            case .level3:
                return Element(msgText: "You got Design power, now you can see things different", instructionText: "")
            case .level4:
                return Element(msgText: "You != User, now with UX power \nthings makes sense to the user", instructionText: "Drag the floors using the mouse to move ahead")
            case .level5:
                return Element(msgText: "If you want to go fast, go alone.\nIf you want to go far, go together.", instructionText: "")
            default:
                return Element(msgText: "", instructionText: "")
        }
    }
}
