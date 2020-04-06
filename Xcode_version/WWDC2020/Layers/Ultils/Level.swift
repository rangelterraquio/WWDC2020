//
//  Level.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 16/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation


///This Enum defines all possible scene in the game.
public enum Level: Int{
    case level1 = 1
    case level2 = 2
    case level3 = 3
    case level4 = 4
    case level5 = 5
    case initialScene = 0
    case finalScene = -1
    
    
    /**
       This method return the next level based on current level.
       
       - parameter currentLevel: The current leval that was played.
       */
    static public func nextLevel(currentLevel: Level) -> Level{
        switch currentLevel {
            case .initialScene:
                return .level1
            case .level1:
                return .level2
            case .level2:
                return .level3
            case .level3:
                return .level4
            case .level4:
                return .level5
            case .level5:
                return .finalScene
            default:
                return .level1
        }
    }
}
