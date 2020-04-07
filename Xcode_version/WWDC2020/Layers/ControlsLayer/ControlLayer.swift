
//
//  ControlsLayer.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 13/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

public class ControlLayer: SKNode{
    
    weak var controlable: ControlProtocol?
    
    var rightPressed = false
    var leftPressed = false
    var spacePressed = false
    
    override public func keyDown(with event: NSEvent) {
        switch event.keyCode {
            case KeyBoardKeys.rightArrow.rawValue:
                //controlable?.rightArrowPressed()
                rightPressed = true
            case KeyBoardKeys.leftArrow.rawValue:
                leftPressed = true
//                controlable?.leftArrowPressed()
            case KeyBoardKeys.space.rawValue:
                spacePressed = true
//                controlable?.spacePressed()
            default:
                controlable?.wKeyPressed()
        }
    }
    
    public override func keyUp(with event: NSEvent) {
          switch event.keyCode {
          case KeyBoardKeys.rightArrow.rawValue:
            //controlable?.rightArrowPressed()
            rightPressed = false
          case KeyBoardKeys.leftArrow.rawValue:
            leftPressed = false
//            controlable?.leftArrowPressed()
          case KeyBoardKeys.space.rawValue:
            spacePressed = false
//            controlable?.spacePressed()
            print("space up")
          default:
            controlable?.wKeyPressed()
        }
    }
    
    func keyPressed(){
        if rightPressed{
           controlable?.rightArrowPressed()
        }
        if leftPressed{
            controlable?.leftArrowPressed()
        }
        if spacePressed{
            controlable?.spacePressed()
        }
    }
    
    override public func mouseDown(with event: NSEvent) {
        controlable?.mousePressed(with: event)
    }
    
    override public func mouseMoved(with event: NSEvent) {
        controlable?.mouseMoving(with: event)
    }
    
    override public func mouseUp(with event: NSEvent) {
        controlable?.mouseUnpressed(with: event)
    }
    
    
}

