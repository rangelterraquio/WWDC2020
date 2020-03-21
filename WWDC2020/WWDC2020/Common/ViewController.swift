//
//  ViewController.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 13/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") as? GameScene{
             if let scene = GameScene(fileNamed: "Level4"){
            // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.currentLevel = .level4
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = false
        }
    }
}

