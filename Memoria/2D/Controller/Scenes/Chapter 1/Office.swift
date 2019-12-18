//
//  Office.swift
//  Memoria
//
//  Created by Delvin on 04/11/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit
import UIKit

class Office: SKScene{
    var state = 1
    var i = 1
    var a = 1
    
    var nextButton = YellowButton()
    let border = SKSpriteNode()
    
    let mobA = SKSpriteNode(imageNamed: "mobA")
    
    let message = "Come with me, and see what has been foretold..."
    
    let elioBG = SKSpriteNode(imageNamed: "Kerja_3")
    
    var spriteManager = SpriteManager.instance
    
    var bubbles = [Bubble]()
    var soloBubble = [Bubble]()
    var index = 0
    var index2 = 0
    var height : CGFloat = 0
    
    
    override func didMove(to view: SKView) {
        FirstPlayer.instance.player?.stop()
        index = 0
        view.isUserInteractionEnabled = false
        
        border.zPosition = 1
        border.anchorPoint = CGPoint(x: 0.5, y: 0)
        border.size = CGSize(width: view.frame.width, height: view.frame.height/4)
        border.position = CGPoint(x: view.frame.width/2, y: 3*view.frame.height/4)
        
        elioBG.name = "background"
        elioBG.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        elioBG.zPosition = -1
        elioBG.size = CGSize(width: view.frame.width, height: view.frame.height)
        
        nextButton = YellowButton(with: CGSize(width: 60, height: 60), text: "➤", textSize: 25)
        nextButton.position = CGPoint(x:view.frame.width-60, y: 60)
        nextButton.zPosition = 7
        nextButton.name = "nextButton"
        nextButton.move(to: .down)
        nextButton.isHidden = true
        addChild(nextButton)
        
        mobA.size = CGSize(width: view.frame.width, height: view.frame.height)
        mobA.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        mobA.zPosition = -0.5
        mobA.alpha = 0
        
        addChild(mobA)
        addChild(elioBG)
        addChild(border)
        
        view.isUserInteractionEnabled = false
        
        self.run(SKAction.wait(forDuration: 1)){
            self.mobA.run(SKAction.fadeAlpha(to: 1, duration: 0.5)){
                view.isUserInteractionEnabled = true
                self.addBubble()
                self.addBubble2()
                self.moveBubble()
                self.view?.isUserInteractionEnabled = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "nextButton"{
                    nextButton.highlight()
                }
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view?.isUserInteractionEnabled = false
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "nextButton"{
                    HapticGenerator.instance.play(sharpnessValue : 0.5, intensityValue : 0.5)
                    FirstPlayer.instance.playSound(for: .soundEffect2D, index: 3)
                    SpriteManager.instance.callScene(index: 6,transition: .fade(withDuration: 1))
                    
                    BGMPlayer.instance.player?.setVolume(0, fadeDuration: 2)
                    self.run(SKAction.wait(forDuration: 2)){
                        BGMPlayer.instance.player?.stop()
                    }
                }
                else if node.name == "background"{
                    if i<bubbles.count{
                        moveBubble()
                        self.run(SKAction.wait(forDuration: 0.5)){
                            self.view?.isUserInteractionEnabled = true
                        }
                        i += 1
                    }
                    else if i == bubbles.count{
                        mobA.run(SKAction.fadeAlpha(to: 0, duration: 1)){
                            for index in 1...self.bubbles.count{
                                self.bubbles[index-1].run(SKAction.fadeAlpha(to: 0, duration: 0.5)){
                                    self.bubbles[index-1].removeFromParent()
                                }
                            }
                        }
                        self.run(SKAction.wait(forDuration: 1)){
                            self.view?.isUserInteractionEnabled = true
                        }
                        i += 2
                    }
                    else if i > bubbles.count{
                        a += 1
                        moveBubble2()
                        self.run(SKAction.wait(forDuration: 0.5)){
                            self.view?.isUserInteractionEnabled = true
                        }
                        }
                    if a == soloBubble.count{
                        self.run(SKAction.wait(forDuration: 1)){
                        self.nextButton.isHidden = false
                        self.nextButton.move(to: .up)
                        self.view?.isUserInteractionEnabled = true
                        }
                    }
                }
            }
        }
    }
    
    func addBubble(){
        let widthOfficeBubble: CGFloat = 260
        let bubbleAlbertPosition = view!.frame.width/2 - 130
        let bubbleJamesPosition = view!.frame.width/2 + 170
        let tSize : CGFloat = 16
        
        let bubble = Bubble()
        let text = "Hey Elio"
        let position = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble.createBubble(position: position, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text, textColor: .white, textSize : tSize)
        bubbles.append(bubble)
        
        let bubble2 = Bubble()
        let text2 = "Yes James?"
        let position2 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble2.createBubble(position: position2, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text2, textColor: .white, textSize : tSize)
        bubbles.append(bubble2)
        
        
        let bubble3 = Bubble()
        let text3 = "Are you busy?"
        let position3 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble3.createBubble(position: position3, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text3, textColor: .white, textSize : tSize)
        bubbles.append(bubble3)
        
        let bubble4 = Bubble()
        let text4 = "Not really, why?"
        let position4 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble4.createBubble(position: position4, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text4, textColor: .white, textSize : tSize)
        bubbles.append(bubble4)
        
        let bubble5 = Bubble()
        let text5 = "The others and I want to hang out after work, do you want to join?"
        let position5 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble5.createBubble(position: position5, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text5, textColor: .white, textSize : tSize)
        bubbles.append(bubble5)
        
        let bubble6 = Bubble()
        let text6 = "Sorry, I don't think I will join you guys."
        let position6 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble6.createBubble(position: position6, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text6, textColor: .white, textSize : tSize)
        bubbles.append(bubble6)
        
        let bubble7 = Bubble()
        let text7 = "You still have stuff to do?"
        let position7 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble7.createBubble(position: position7, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text7, textColor: .white, textSize : tSize)
        bubbles.append(bubble7)
        
        let bubble8 = Bubble()
        let text8 = "Not really, I just don't feel like it today."
        let position8 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble8.createBubble(position: position8, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text8, textColor: .white, textSize : tSize)
        bubbles.append(bubble8)
        
        let bubble9 = Bubble()
        let text9 = "Anything I can help you with?"
        let position9 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble9.createBubble(position: position9, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text9, textColor: .white, textSize : tSize)
        bubbles.append(bubble9)
        
        let bubble9a = Bubble()
        let text9a = "You seem out of it these past few days."
        let position9a = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble9a.createBubble(position: position9a, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text9a, textColor: .white, textSize : tSize)
        bubbles.append(bubble9a)
        
        let bubble10 = Bubble()
        let text10 = "I just need a bit of time for myself, I think."
        let position10 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble10.createBubble(position: position10, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text10, textColor: .white, textSize : tSize)
        bubbles.append(bubble10)
        
        let bubble11 = Bubble()
        let text11 = "Well okay, just call me later if you change your mind."
        let position11 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble11.createBubble(position: position11, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text11, textColor: .white, textSize : tSize)
        bubbles.append(bubble11)
        
        let bubble12 = Bubble()
        let text12 = "I will."
        let position12 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble12.createBubble(position: position12, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text12, textColor: .white, textSize : tSize)
        bubbles.append(bubble12)
        
    }
    
    func addBubble2(){
        let widthOfficeBubble: CGFloat = 260
        let bubbleAlbertPosition = view!.frame.width/2 - 130
        let tSize : CGFloat = 16
        
        let bubble13 = Bubble()
               let text13 = "Sigh."
               let position13 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
               bubble13.createBubble(position: position13, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text13, textColor: .white, textSize : tSize)
               soloBubble.append(bubble13)
        
        let bubble14 = Bubble()
               let text14 = "I don't think that i am really cut out for this kind of office work."
               let position14 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
               bubble14.createBubble(position: position14, width: 230, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text14, textColor: .white, textSize : tSize)
               soloBubble.append(bubble14)
        
        let bubble15 = Bubble()
               let text15 = "It's somewhat stifling."
               let position15 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
               bubble15.createBubble(position: position15, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text15, textColor: .white, textSize : tSize)
               soloBubble.append(bubble15)
        
        let bubble16 = Bubble()
               let text16 = "I will just go home, I guess..."
               let position16 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
               bubble16.createBubble(position: position16, width: widthOfficeBubble, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text16, textColor: .white, textSize : tSize)
               soloBubble.append(bubble16)
    }
    
    func moveBubble(){
        if index < bubbles.count {
            addChild(bubbles[index])
            height = bubbles[index].height + 5
            if index != 0 {
                for i in 0..<index{
                    bubbles[i].run(SKAction.moveBy(x: 0, y: height, duration: 0.5))
                }
            }
            bubbles[index].alpha = 0
            self.run(SKAction.wait(forDuration: 0.2)) {
                self.bubbles[self.index-1].run(SKAction.fadeAlpha(to: 1, duration: 0.3))
            }
            index += 1

        }
    }
    
    func moveBubble2(){
        if index2 < soloBubble.count {
            addChild(soloBubble[index2])
            height = soloBubble[index2].height + 5
            if index2 != 0 {
                for i in 0..<index2{
                    soloBubble[i].run(SKAction.moveBy(x: 0, y: height, duration: 0.5))
                }
            }
            soloBubble[index2].alpha = 0
            self.run(SKAction.wait(forDuration: 0.2)) {
                self.soloBubble[self.index2-1].run(SKAction.fadeAlpha(to: 1, duration: 0.3))
            }
            index2 += 1
        }
    }
}
