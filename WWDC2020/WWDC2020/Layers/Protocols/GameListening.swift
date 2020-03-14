//
//  GameListening.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 13/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation


/**
 This protocol define all behaviors of that game to be oberved
*/
protocol GameListening{
    
    /**
    This method is triggered when the game layer will start a level.
    - parameter level: The level that will start.
    */
    func willStart(_ level: Int) -> Void
    
    /**
    This method is triggered when the game layer finishes a level.
    
    - parameter level: The leve that was finished.
    */
    func finished(_ level: Int) -> Void
    
}
