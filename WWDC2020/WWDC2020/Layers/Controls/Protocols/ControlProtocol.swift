//
//  ControlProtocol.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 13/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation

/**
 This protocol defines all controls of the game.
 */
public protocol ControlProtocol{
    
    func leftArrowPressed() -> Void
    func rightArrowPressed() -> Void
    func leftArrowUnpressed() -> Void
    func rightArrowUnpressed() -> Void
    func spacePressed() -> Void
    func aKeyPressed() -> Void
    func wKeyPressed() -> Void
    func dKeyPressed() -> Void
    func sKeyPressed() -> Void
    
}




/**
 This enum defines all possible sides the caracter can move .
 */
public enum Side: CGFloat{
    case right = 1.0
    case left = -1.0
}
