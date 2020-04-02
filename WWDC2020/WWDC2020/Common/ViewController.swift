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
            view.frame = CGRect(x: 0.5, y: 0.5, width: 1024, height: 768)
//             Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") as? GameScene{
             if let scene = GameScene(fileNamed: "Level5"){
            // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.currentLevel = .level5
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
//            view.showsPhysics = true
            view.showsFields = true
        }
    }
}

