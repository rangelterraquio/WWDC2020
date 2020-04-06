//
//  HudControl.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 16/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation


public protocol HudControl: class {
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
}
