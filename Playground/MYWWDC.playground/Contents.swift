//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

/*:
### Overview
#### WWDC20 - Rangel Dias

 ## MY FIRST APP JOURNEY
 
This is a 2D game where the purpose of it's show the joruney of how I create my first IOS app and published it, the player go through five different level where he will be faced to the challenges and learnings I've had on this process. The game is made by SpriteKit and it's supported to MacOS.


 
- Level 1:
**The first level is about the beginning of everything. I always saw a computer program and kept wondering how it was done, I was always fascinated with how we could start from an idea to hundreds of lines of code and it could change people's lives. However, like everything new in life, this for me was something very distant from my reality, everything very obscure and I didn't even know where to start.
This level seeks to show this difficulty that I had as I overcame it through a tool that I met in a project that I participate in the university, it is a learning methodology called CBL [challange based learning](http://cbl.digitalpromise.org) , this methodology provides an efficient and effective framework for learning while solving real-world challenges. The framework fuels collaboration between students, teachers, families, and community members to identify big ideas, ask thoughtful questions, and identify, investigate and solve challenges. This approach helped me gain courage, motivation to develop my skills necessary to reach my goals, since I've started apply this methodology in my life things becomes getting less obscure. **
 
 - Level 2:
**Creating things with just a computer and willpower for me is like a super power and I wanted to have this super power to create things, create new solutions, games, reinvent myself. Level two is about my journey in apple technologies and how they helped make my dream of my first app easier. **

 - Level 3:
**The third level is about Design and how to transform that whole complex idea of thousands of lines of code into an interface, an interface that is not only beautiful, but that makes sense, is functional for the user, and for that we really have to understand the problem as our application will solve it.**
 
 - Level 4:
**The fourth level is about experience, what makes a moment or something remarkable is the experience we had at that moment or using that product. As we are creating an application, the target audience is probably different from you, this was one of the biggest lessons I learned during this journey, that we are different from the user. Our duty is to understand the user to create the best experience for him, that is functional and accessible to anyone.**
 
 - Level 5:
**If you want to go fast, go alone. If you want to go far, go together. The fifth level is about how joining forces makes all the difference, that it doesn't matter if you have the knowledge of everything, when we add ideas we can create great things and how in a group each one can complete the other. The fifth shows that we always need to be surrounded by good people and to know and at the same time know how to deal with differences if we want to make a difference and create wonderful things.**
 
 #### How to Play
 
///  Use left and right arrow to roll sideways
///  Use space key  to jump
///  Collect itens to get superpowers to be able to go ahead
 
 
######I hope you have fun. */






// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 1024, height: 768))

if let scene = GameScene(fileNamed: "Scenes/Level1") {
   

    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    scene.currentLevel = .level1
    // Present the scene
    sceneView.showsPhysics = false
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

