//
//  GameScene.swift
//  Memoria
//
//  Created by Delvin on 21/10/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class MobilScene: SKScene {
    let button = SKSpriteNode(imageNamed: "nextButton.png")
    let ibuAnak = SKSpriteNode(imageNamed: "Ibu Anak")
    let ayah = SKSpriteNode(imageNamed: "Ayah Ibu Anak")
    let paper = SKSpriteNode()
    let paperBig = SKSpriteNode(imageNamed: "Paper")
    let blocker = SKSpriteNode()
    
    var monologue = Monologue()
    var nextButton = YellowButton()
    
    let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.5)
    let fadeOut = SKAction.fadeAlpha(by: -1, duration: 0.5)
    
    let hint = SKSpriteNode(imageNamed: "Hint")
    let pulse = [SKAction.fadeAlpha(to: 0.8, duration: 1), SKAction.wait(forDuration: 0.3), SKAction.fadeAlpha(to: 0, duration: 1), SKAction.wait(forDuration: 0.8)]
    
    var statePaper = 1
    var stateButton = 1
    
    var border = SKSpriteNode()
    var secondMonologueOut = false
    
    let monologues = [
    "The earliest memory I could still remember is that day...",
    "The day I met them, my 'new' family."
    ]
    
    override func didMove(to view: SKView) {
        monologue = Monologue(for: view)
        monologue.changeText(to: monologues[0])
        addChild(monologue)
        monologue.fadeIn()
        
        //Declaring Node
        ibuAnak.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ibuAnak.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 50)
        ibuAnak.zPosition = -1
        ibuAnak.setScale(0.6)
        ibuAnak.name = "ibuAnak"
        
        ayah.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ayah.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        ayah.zPosition = 0
        ayah.setScale(0.5)
        ayah.alpha = 0
        
        paper.name = "paper"
        paper.position = CGPoint(x: 250, y: 30)
        paper.zPosition = 1
        paper.size = CGSize(width: 150, height: 60)
        
        blocker.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        blocker.zPosition = 2
        blocker.size = CGSize(width: view.frame.width, height: view.frame.height)
        blocker.color = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        blocker.alpha = 0
        
        paperBig.name = "paperBig"
        paperBig.zPosition = 2
        paperBig.position = CGPoint(x: view.frame.width/2, y: -view.frame.height/2)
        paperBig.size = CGSize(width: 950, height: 500)
                
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.position = CGPoint(x:view.frame.width-60, y: 60)
        button.zPosition = 4
        button.name = "nextButton"
        button.size = CGSize(width: 110, height: 100)
        button.alpha = 0
        
        nextButton = YellowButton(with: CGSize(width: 60, height: 60), text: "➤", textSize: 25)
        nextButton.position = CGPoint(x:view.frame.width-60, y: 60)
        nextButton.zPosition = 4
        nextButton.name = "nextButton"
        nextButton.move(to: .down)
        nextButton.isHidden = true
        addChild(nextButton)
        
        hint.position = paper.position
        hint.zPosition = 5
        hint.size = CGSize(width: 150, height: 150)
        hint.alpha = 0
        
        addChild(ibuAnak)
        addChild(ayah)
        addChild(paper)
        addChild(blocker)
        addChild(paperBig)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "nextButton" {
                    nextButton.highlight()
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Registering Touch Actions
        nextButton.reset()
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
                
            for node in nodesarray {
                if node.name == "paper" {
                    if statePaper == 1{
                        playAdoptionSound()
                        blocker.run(SKAction.fadeAlpha(to: 0.5, duration: 1))
                        let upAction = SKAction.move(to: CGPoint(x: view!.frame.width/2, y: view!.frame.height/2), duration: 1.5)
                        upAction.timingMode = .easeInEaseOut
                        paperBig.run(upAction){
                            self.nextButton.isHidden = false
                            self.nextButton.move(to: .up)
                        }
                        button.alpha = 1
                        monologue.fadeOut()
                        statePaper += 1
                        
                        hint.removeFromParent()
                    }
                }
                else if node.name == "ibuAnak" && !secondMonologueOut {
                    let duration = 1.0
                    let timing : SKActionTimingMode = .easeOut
                    secondMonologueOut = true
                    monologue.fadeOut()
                    let scale = SKAction.scale(to: 0.5, duration: duration)
                    let move = SKAction.move(to: CGPoint(x: view!.frame.width/2, y: view!.frame.height/2), duration: duration)
                    scale.timingMode = timing
                    move.timingMode = timing
                    ibuAnak.run(move)
                    ibuAnak.run(scale)
                    
                    let dadAdd = SKAction.customAction(withDuration: duration) { (SKNode, CGFloat) in
                        self.ayah.run(SKAction.fadeIn(withDuration: duration))
                        self.monologue.changeText(to: self.monologues[1])
                        self.monologue.fadeIn()
                    }
                    
                    self.run(SKAction.sequence([SKAction.wait(forDuration: duration), dadAdd]))
                    self.addChild(hint)
                    self.run(SKAction.wait(forDuration: 8)){
                        self.hint.run(SKAction.repeatForever(SKAction.sequence(self.pulse)))
                    }
                }
                else if node.name == "nextButton" {
                    HapticGenerator.instance.play(sharpnessValue : 0.5, intensityValue : 0.5)
                    SpriteManager.instance.callScene(index: 3, transition: .fade(withDuration: 1))
                }
            }
        }
    }
    
    func playAdoptionSound(){
        FirstPlayer.instance.playSound(for: part.chapter1, index: 1)
    }
}
