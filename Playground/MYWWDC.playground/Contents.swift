//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

/*:
### Overview
#### WWDC20 - Rangel Dias 👨🏽‍💻.

 ## MY FIRST APP JOURNEY
 
This is a 2D game where the purpose is to show the journey of how I’ve created my first IOS app and published it, the player goes through five different levels in which he will face challenges and learnings I've had on this process. The game is made by SpriteKit and it's supported to MacOS 💻..
 
### Level 1

 The first level is about the beginning of everything. I always saw a computer program and kept wondering how it was done, I was always fascinated about how we could start from an idea to hundreds of lines of codes and how it could change people’s lives. However, like everything new in life, this for me was something very distant from my reality, everything was very obscure and I didn’t even know where to start.

 This level seeks to show this difficulty that I had and how I overcame it through a tool that I met in a project that I took part in the university, it is a learning methodology called CBL [challange based learning](http://cbl.digitalpromise.org) , this methodology provides an efficient and effective framework for learning while solving real-world challenges. The framework fuels collaboration between students, teachers, families, and community members to identify big ideas, ask thoughtful questions, and identify, investigate and solve challenges. This approach helped me gain courage and motivation to develop the necessary skills to reach my goals and since I’ve started applying this methodology in my life things became less obscure.

### Level 2

 Creating things with just a computer and your willpower for me is like a superpower and I wanted to have this superpower to create things, create new solutions, games, reinvent myself. Level two is about my journey in apple’s technologies and how they  helped make my dream of the first app easier.
 
### Level 3
 
 The third level is about Design and how it helps to transform that complex idea in something simple, an interface that is not only beautiful, but also make sense and is functional for the user.  This level shows how important is to truly understand the problem our application is solving and the best way to find a most accurate solution for that problem is by making tests, we should always test different possibilities, because what you think is not what someone else thinks.
 
 ### Level 4
 
 The fourth level is about experience, what makes a moment or something remarkable is the experience we had at that moment or using that product.  When we are developing a product, the target audience is probably different from you, this was one of the biggest lessons I’ve learned during this journey. Our compromise is to understand the users and their necessities to create the best experience for the user, a product that is functional and accessible to anyone.
 
 ### Level 5

 f you want to go fast, go alone. If you want to go far, go together. The fifth level is about how joining forces makes all the difference, it doesn’t matter if you have all knowledge, in your journey you always need the help of someone else. The fifth level shows how soft skills can affect the team productivity, how we should deal with differences, always keeping a good communication and specially, how teamwork is essential in any field of our lives.
 
 ## **How to Play**🕹
  
 - **Use left and right arrow key  to roll sideways**.
 - **Use space key to jump**.
 - **Collect items to get super powers and help you go ahead**.
  
  
 ### **I hope you have fun.**  😀
*/
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 1024, height: 768))

// Load the SKScene from 'GameScene.sks'
if let scene = GameScene(fileNamed: "Scenes/Level1") {

    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    //Defines the current level.
    scene.currentLevel = .level1
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

