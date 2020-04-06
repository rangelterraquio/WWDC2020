//
//  InteractiveNode.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 14/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

/**
This protocol defines an interface for all node that has some kind of interaction in game.
*/
 public protocol InteractiveNode{
    
    /**
    This method defines what will happen to the node when it interacts.
     - parameter contact: A contact where interaction takes place.
     */
    func interact(with contact: SKPhysicsContact?)
//    @objc optional func interact()
    
    /**
    This method setup the node when it is loaded.
    */
    func didMoveToScene()
    
    
}

/**
This protocol defines an interface for all node that has some kind of interaction in game and is collactable.
*/
public protocol Collectable: InteractiveNode, ObservableProtocol {
    var lifeNode: Int  {get set}
}
