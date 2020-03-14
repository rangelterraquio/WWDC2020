//
//  InteractiveNode.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 14/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation


/**
This protocol defines an interface for all node that has some kind of interaction in game.
*/
public protocol InteractiveNode{
    
    /**
    This method defines what will happen to the node when it interacts.
    */
    func interact()
    
    /**
    This method setup the node when it is loaded.
    */
    func didMoveToScene()
}
