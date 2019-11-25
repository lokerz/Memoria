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
    var stateBacot = 1
    var stateSekarang = 1
    let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.7)
    let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.7)
    
    let button = SKSpriteNode(imageNamed: "nextButton")
    
    let bacot = [
        "Lost",
        "Stucked",
        "Trapped in the spinning wheel of life",
        "To the point where you could not think",
        "What is the purpose of your life?",
        "Now I will share a story",
        "A story which will change my whole life forever",
        "My name is Albert",
        "And this is my story"
    ]
    
    override func didMove(to view: SKView) {
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.position = CGPoint(x:view.frame.width-60, y: 60)
        button.zPosition = 4
        button.name = "nextButton"
        button.setScale(0.4)
        
        background.name = "background"
        background.color = .black
        background.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        background.size = CGSize(width: view.frame.width, height: view.frame.height)
        
        prologue.fontName = "Helvetica Neue Light"
        prologue.horizontalAlignmentMode = .center
        prologue.verticalAlignmentMode = .center
        prologue.name = "prologue"
        prologue.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        prologue.fontSize = 32
        prologue.numberOfLines = 3
        prologue.preferredMaxLayoutWidth = view.frame.width - 200
        prologue.alpha = 0
        
        addChild(background)
        addChild(prologue)
        
        self.prologue.run(self.fadeIn)
        prologue.text = bacot[0]
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.prologue.run(self.fadeOut)
        }
        
        var i = 1
        
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
            if i < self.bacot.count{
                self.prologue.run(self.fadeIn)
                self.prologue.text = self.bacot[i]
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.prologue.run(self.fadeOut)
                }
                i += 1
            }
            else{
                let scene = SpriteManager.instance.callScene(index: 2)
                self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
            }
        }
        
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }
    
}
