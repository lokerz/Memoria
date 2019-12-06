//
//  Prologue.swift
//  Memoria
//
//  Created by Delvin on 14/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import SpriteKit

class Prologue: SKScene {
    let prologue = SKLabelNode()
    let background = SKSpriteNode()
    
    let skipButton = SKSpriteNode()
    
    var stateBacot = 1
    var stateSekarang = 1
    let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.7)
    let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.7)
    
    let button = SKSpriteNode(imageNamed: "nextButton")
    
    let prologues = [
        "Lost without direction...",
        "trapped in inhibition...",
        "In this stagnant life...",
//        "to the point where one could not think",
//        "what is the purpose of your life?",
//        "Now I will share a story",
//        "A story which will change my whole life forever",
        "what do you live for?",
        "I am elio",
//        "And this is my story"
    ]
    var sequences = [SKAction]()
    
    override func didMove(to view: SKView) {
        button.position = CGPoint(x:view.frame.width-60, y: 60)
        button.zPosition = 4
        button.name = "nextButton"
        button.setScale(0.4)
        
        background.name = "background"
        background.color = .black
        background.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        background.size = CGSize(width: view.frame.width, height: view.frame.height)
        
        prologue.fontName = "Roboto-Regular"
        prologue.horizontalAlignmentMode = .center
        prologue.verticalAlignmentMode = .center
        prologue.name = "prologue"
        prologue.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        prologue.fontSize = 28
        prologue.numberOfLines = 3
        prologue.preferredMaxLayoutWidth = view.frame.width - 200
        prologue.alpha = 0
        
        skipButton.name = "Skip"
        skipButton.run(SKAction.setTexture(SKTexture(imageNamed: "SkipWhite"),resize: true))
        skipButton.zPosition = 4
        skipButton.position = CGPoint(x: view.frame.width - 70, y: 40)
        skipButton.alpha = 0
        
        addChild(skipButton)
        
        addChild(background)
        addChild(prologue)
        
        let fadeInSkip = [SKAction.wait(forDuration: 5), SKAction.fadeAlpha(to: 1, duration: 1)]

        skipButton.run(SKAction.sequence(fadeInSkip))
        
        showText(string: prologues[0], duration: 2)
        showText(string: prologues[1], duration: 2)
        showText(string: prologues[2], duration: 2)
        showText(string: prologues[3], duration: 3)
        showText(string: prologues[4], duration: 3)
        changeScene()
        
        let sequence = SKAction.sequence(sequences)
        prologue.run(sequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "Skip"{
                    skipButton.run(SKAction.setTexture(SKTexture(imageNamed: "SkipSelected"),resize: true))
                }
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetButton()
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "Skip"{
                    HapticGenerator.instance.play(sharpnessValue: 0.5, intensityValue: 0.5)
                    SpriteManager.instance.callScene(index: 2, transition: .fade(withDuration: 1))
                }
            }
        }
    }
    
    func showText(string: String, duration : Double){
        let changeText = SKAction.customAction(withDuration: 1) { _,_  in
            self.prologue.text = string
        }
        let wait = SKAction.wait(forDuration: duration)
        sequences.append(changeText)
        sequences.append(fadeIn)
        sequences.append(wait)
        sequences.append(fadeOut)
    }
    
    func changeScene(){
        let changeScene = SKAction.customAction(withDuration: 0) { (SKNode, CGFloat) in
            SpriteManager.instance.callScene(index: 2, transition: .fade(withDuration: 1))
        }
        sequences.append(changeScene)
        
    }
    
    func resetButton(){
        skipButton.run(SKAction.setTexture(SKTexture(imageNamed: "SkipWhite"),resize: true))
    }
}
