
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
    
    var controlable: ControlProtocol?
    
    override public func keyDown(with event: NSEvent) {
        switch event.keyCode {
            case KeyBoardKeys.rightArrow.rawValue:
                controlable?.rightArrowPressed()
            case KeyBoardKeys.leftArrow.rawValue:
                controlable?.leftArrowPressed()
            case KeyBoardKeys.space.rawValue:
                controlable?.spacePressed()
            default:
                print("")
        }
    }
    
    
    
    
    
}
