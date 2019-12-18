//
//  EndingOne.swift
//  Memoria
//
//  Created by Delvin on 14/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import SpriteKit

class EndingOne: SKScene {
    
    var ending = SKSpriteNode()
    var endingFoto = SKSpriteNode()
    
    var sequences = [SKAction]()
    let fadeIn = SKAction.fadeIn(withDuration: 3)
    let fadeOut = SKAction.fadeOut(withDuration: 3)

    let bubble = Bubble()
    var state = 0
    
    var monologue = Monologue()
    var monologues = [
    "Who, who is that girl?",
    "Why can't I remember her?",
    "I think I know where I should go..."
    ]
    
    var isClickable = false
    
    override func didMove(to view: SKView) {
        monologue = Monologue(for: view)
        monologue.changeText(to: monologues[0])
        addChild(monologue)
        
        playSound()
        
        ending = addImage(to: view, name: "endingOne")
        ending.alpha = 0
        ending.run(fadeIn.easeInOut()){
            self.isClickable = true
        }
        
        endingFoto = addImage(to: view, name: "endingFoto")
        endingFoto.alpha = 0

        let widthOfficeBubble: CGFloat = 260
        let bubbleReshaPosition = self.view!.frame.width/2 - 5
        let tSize : CGFloat = 16
    
        let text = "Elio, don’t forget to come back"
        let position = CGPoint(x: bubbleReshaPosition, y: self.view!.frame.height/2 - 10)
        bubble.createBubble(position: position, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), type: .bottomLeft, text: text, textColor: .white, textSize : tSize)
        
        bubble.zPosition = 1
        addChild(bubble)
        bubble.alpha = 0
    }
    
    func addImage(to view : SKView, name : String) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: name)
        node.name = name
        node.size = view.frame.size
        node.position = view.center
        addChild(node)
        return(node)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
            for node in nodesarray {
                if node.name == "endingOne" && isClickable{
                    if state == 0{
                        self.view?.isUserInteractionEnabled = false
                        bubble.run(SKAction.fadeAlpha(to: 1, duration: 1)){
                            self.view?.isUserInteractionEnabled = true
                        }
                        state += 1
                    }
                    else if state == 1{
                        monologue.fadeIn()
                        bubble.run(SKAction.fadeAlpha(to: 0, duration: 1))
                        state += 1
                    }
                    else if state == 2{
                        monologue.changeText(to: monologues[1])
                        state += 1
                    }
                    else if state == 3{
                        HapticGenerator.instance.play(sharpnessValue : 0.5, intensityValue : 0.5)
                        isClickable = false
                        monologue.run(fadeOut.easeInOut())
                        ending.run(fadeOut.easeInOut()){
                            self.endingFoto.run(self.fadeIn.easeInOut()){
                                self.isClickable = true
                                self.state += 1
                            }
                        }
                    }
                } else if node.name == "endingFoto" && isClickable{
                    if state == 4{
                        monologue.changeText(to: monologues[2])
                        monologue.fadeIn()
                        state += 1
                    }
                    else if state == 5{
                        HapticGenerator.instance.play(sharpnessValue : 0.5, intensityValue : 0.5)
                        isClickable = false
                        monologue.run(fadeOut.easeInOut())
                        endingFoto.run(fadeOut.easeInOut()){
                            self.changeScene()
                        }
                    }
                }
            }
            
        }
    }
    
    func changeScene(){
        SpriteManager.instance.callChapterSelect(index: 2, transition: .fade(with : .white, duration : 2))
    }
    
    func playSound(){
        BGMPlayer.instance.playSound(for: part.mainMenu, index: 1, volume: 0)
        BGMPlayer.instance.player?.setVolume(1, fadeDuration: 1)
    }
}
