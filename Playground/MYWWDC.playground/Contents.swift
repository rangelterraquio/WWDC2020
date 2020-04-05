//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit


// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 1024, height: 768))

if let scene = GameScene(fileNamed: "Level2") {
   

    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    scene.currentLevel = .level2
    // Present the scene
    print(scene)
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

