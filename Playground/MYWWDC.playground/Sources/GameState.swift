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
public protocol GameState: class{
    
    ///This property indicates if game has started or not.
    var gameStarted: Bool {get set}
    /**
    This method is triggered when the game layer will start a level.
    - parameter level: The level that will start.
    */
    func willStart(_ level: Level) -> Void
    
    /**
    This method is triggered when the game layer finishes a level.
    
    - parameter level: The leve that was finished.
    */
    func finished(_ currentlevel: Level) -> Void
    
    
    /**
    This method is triggered when the game layer finishes a level to call a new one.
    
    - parameter level: The next level to be played.
    */
    func startNewLevel() ->  Void
    
    /**
    This method is triggered when the game layer finishes a level to call a new one.
    
    - parameter level: The next level to be played.
    */
    func showMsgText() ->  Void
    
    /**
    This method is triggered when the game layer finishes a level to call a new one.
    
    - parameter level: The next level to be played.
    */
    func showInstructionText() ->  Void
    
    /**
    This method is triggered when the game layer finishes a level to call a new one.
    
    - parameter level: The next level to be played.
    */
    func updatePowerProgress() -> Void
}
