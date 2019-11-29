//
//  PaperWork.swift
//  Memoria
//
//  Created by Delvin on 01/11/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class PaperWork: SKScene {
    private var currentNode: SKNode?
    var nodePosition = CGPoint()
    var startTouch = CGPoint()
    
    let albertWork = SKSpriteNode()
    let pen = SKSpriteNode(imageNamed: "pen")
    
    var writeState = 1
    
    let paper1_1 = SKSpriteNode()
    let paper1_2 = SKSpriteNode()
    let paper1_3 = SKSpriteNode()
    let paper2 = SKSpriteNode()
    
    let text11 = SKSpriteNode(imageNamed: "text_11")
    let text12 = SKSpriteNode(imageNamed: "text_12")
    let text13 = SKSpriteNode(imageNamed: "text_13")
    
    let text21 = SKSpriteNode(imageNamed: "text_21")
    let text22 = SKSpriteNode(imageNamed: "text_22")
    
    let text31 = SKSpriteNode(imageNamed: "text_31")
    let text32 = SKSpriteNode(imageNamed: "text_32")
    let text33 = SKSpriteNode(imageNamed: "text_33")
    
    let detector = SKSpriteNode()
    
    var nextButton = YellowButton()
    
    let paperSize = CGSize(width: 300, height: 380)
    let textSize = CGSize(width: 270, height: 370)
    
    let fadeIn = SKAction.fadeIn(withDuration: 1.2).easeInOut()
    let fadeInSlow = SKAction.fadeIn(withDuration: 2).easeInOut()
    let fadeOut = SKAction.fadeOut(withDuration: 1.2).easeInOut()
    
    
    override func didMove(to view: SKView) {
        view.isUserInteractionEnabled = false
        let text1Pos = CGPoint(x: 7*view.frame.width/10, y: view.frame.height/2)
        let text2Pos = CGPoint(x: 7*view.frame.width/10 + 10, y: view.frame.height/2)
        let text3Pos = CGPoint(x: 7*view.frame.width/10 + 15, y: view.frame.height/2)
        
        let Paper = SKTexture(imageNamed: "Kertas")
        let setPaper = SKAction.setTexture(Paper)
        
        SpriteManager.instance.removeGesture(from : view)
        
        albertWork.run(SKAction.setTexture(SKTexture(imageNamed: "Kerja_1")))
        albertWork.name = "Albert"
        albertWork.size = CGSize(width: view.frame.width, height: view.frame.height)
        albertWork.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        albertWork.zPosition = 1
        albertWork.alpha = 0
        
        albertWork.position = CGPoint(x: view.frame.width/2 - 400, y: view.frame.height/2 + 340)
        albertWork.setScale(5)
        
        
        paper1_1.run(setPaper)
        paper1_1.name = "paper11"
        paper1_1.position = CGPoint(x: view.frame.width, y: view.frame.height/2)
        paper1_1.size = paperSize
        paper1_1.zPosition = 4
        paper1_1.alpha = 0
        
        paper1_2.run(setPaper)
        paper1_2.name = "paper12"
        paper1_2.position = CGPoint(x: view.frame.width+10, y: view.frame.height/2-10)
        paper1_2.size = paperSize
        paper1_2.zPosition = 3
        paper1_2.alpha = 0
        
        paper1_3.run(setPaper)
        paper1_3.name = "paper13"
        paper1_3.position = CGPoint(x: view.frame.width+15, y: view.frame.height/2-14)
        paper1_3.size = paperSize
        paper1_3.zPosition = 2
        paper1_3.alpha = 0
        
        text11.size = textSize
        text11.position = text1Pos
        text11.zPosition = 5
        text11.alpha = 0
        
        text12.size = textSize
        text12.position = text1Pos
        text12.zPosition = 5
        text12.alpha = 0
        
        text13.size = textSize
        text13.position = text1Pos
        text13.zPosition = 5
        text13.alpha = 0
        
        text21.size = textSize
        text21.position = text2Pos
        text21.zPosition = 5
        text21.alpha = 0
        
        text22.size = textSize
        text22.position = text2Pos
        text22.zPosition = 5
        text22.alpha = 0
        
        text31.size = textSize
        text31.position = text3Pos
        text31.zPosition = 5
        text31.alpha = 0
        
        text32.size = textSize
        text32.position = text3Pos
        text32.zPosition = 5
        text32.alpha = 0
        
        text33.size = textSize
        text33.position = text3Pos
        text33.zPosition = 5
        text33.alpha = 0
        
        detector.name = "detector"
        detector.position = CGPoint(x: 7*view.frame.width/10, y: view.frame.height/2)
        detector.size = paperSize
        detector.zPosition = 0
        
        pen.anchorPoint = CGPoint(x: 0.38, y: 0.38)
        pen.position = paper1_1.position
        pen.name = "pen"
        pen.zPosition = 6
        pen.setScale(0.12)
        pen.alpha = 0
        
        nextButton = YellowButton(with: CGSize(width: 60, height: 60), text: "➤", textSize: 25)
        nextButton.position = CGPoint(x:view.frame.width-60, y: 60)
        nextButton.zPosition = 7
        nextButton.name = "nextButton"
        nextButton.move(to: .down)
        nextButton.isHidden = true
        addChild(nextButton)
        
        addChild(detector)
        addChild(albertWork)
        
        addChild(paper1_1)
        addChild(paper1_2)
        addChild(paper1_3)
        addChild(pen)
        
        albertWork.run(fadeIn)
        
        let wait = SKAction.wait(forDuration: 1)
        let action1 = SKAction.customAction(withDuration: 2) { (SKNode, CGFloat) in
            let scale = SKAction.scale(to: 1, duration: 2)
            let move = SKAction.move(to: CGPoint(x: view.frame.width/2, y: view.frame.height/2), duration: 2)
            scale.timingMode = .easeIn
            move.timingMode = scale.timingMode
            self.albertWork.run(scale)
            self.albertWork.run(move)
        }
        let action2 = SKAction.customAction(withDuration: 2) { (SKNode, CGFloat) in
            let moveIn1 = SKAction.moveTo(x: 7 * view.frame.width/10, duration: 1.2)
            let moveIn2 = SKAction.moveTo(x: 7 * view.frame.width/10 + 10, duration: 1.2)
            let moveIn3 = SKAction.moveTo(x: 7 * view.frame.width/10 + 15, duration: 1.2)
            self.paper1_1.run(moveIn1)
            self.paper1_2.run(moveIn2)
            self.paper1_3.run(moveIn3)
            self.pen.run(moveIn1)
            self.paper1_1.run(self.fadeIn)
            self.paper1_2.run(self.fadeIn)
            self.paper1_3.run(self.fadeIn)
            self.pen.run(self.fadeIn)
//            self.pen.run(SKAction.sequence([SKAction.wait(forDuration: 2), self.fadeIn]))
        }
        let sequence = SKAction.sequence([wait, action1, wait, wait])
        sequence.timingMode = .easeInEaseOut
        self.run(sequence){
            self.run(action2)
            self.run(wait){
                view.isUserInteractionEnabled = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "detector" {
                    startTouch = location
                    nodePosition = node.position
                    HapticGenerator.instance.play(4)
                    albertAnimation()
                }
                    
                else if node.name == "nextButton"{
                    nextButton.highlight()
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point1 = CGPoint(x: self.paper1_1.position.x, y: view!.frame.height/2 + 100)
        let point2 = CGPoint(x: self.paper1_2.position.x + 10, y: view!.frame.height/2 + 90)
        
        let move1 = SKAction.move(to: point1, duration: 1)
        let move2 = SKAction.move(to: point2, duration: 1)
        
        if let touch = touches.first{
            let touchLocation = touch.location(in: self)
            if touchLocation.x < paper1_1.position.x - 100{
                
            }
            else if touchLocation != startTouch{
                pen.position = touchLocation
                let a = 72
                
                writeState += 1
                if writeState == 5{
                    addChild(text11)
                    text11.run(fadeInSlow)
                }
                if writeState == a{
                    addChild(text12)
                    text12.run(fadeInSlow)
                }
                if writeState == 2 * a{
                    addChild(text13)
                    text13.run(fadeInSlow)
                }
                if writeState == 3 * a{
                    self.paper1_1.run(move1)
                    self.text11.run(move1)
                    self.text12.run(move1)
                    self.text13.run(move1)
                    self.paper1_1.run(self.fadeOut)
                    self.text11.run(self.fadeOut)
                    self.text12.run(self.fadeOut)
                    self.text13.run(self.fadeOut)
                }
                if writeState == 4 * a{
                    paper1_1.removeFromParent()
                    text11.removeFromParent()
                    text12.removeFromParent()
                    text13.removeFromParent()
                    addChild(text21)
                    text21.run(fadeInSlow)
                }
                if writeState == 5 * a{
                    addChild(text22)
                    text22.run(fadeInSlow)
                }
                
                if writeState == 6 * a{
                    self.paper1_2.run(move2)
                    self.text21.run(move2)
                    self.text22.run(move2)
                    self.paper1_2.run(self.fadeOut)
                    self.text21.run(self.fadeOut)
                    self.text22.run(self.fadeOut)
                }
                if writeState == 7 * a{
                    paper1_2.removeFromParent()
                    text21.removeFromParent()
                    text22.removeFromParent()
                    addChild(text31)
                    text31.run(fadeInSlow)
                }
                if writeState == 8 * a{
                    addChild(text32)
                    text32.run(fadeInSlow)
                }
                if writeState == 9 * a{
                    addChild(text33)
                    text33.run(fadeInSlow){
                        self.nextButton.isHidden = false
                        self.nextButton.move(to: .up)
                    }
                }
            }
        }
        
        super.touchesMoved(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        nextButton.reset()
        HapticGenerator.instance.play(4)
        albertWork.removeAction(forKey: "Key")
        
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "nextButton" {
                    HapticGenerator.instance.play(sharpnessValue : 0.5, intensityValue : 0.5)
                    SpriteManager.instance.callScene(index: 5)
                }
            }
        }
    }
    
    func albertAnimation(){
        let f0 = SKTexture.init(imageNamed: "Kerja_1")
        let f1 = SKTexture.init(imageNamed: "Kerja_2")
        let f2 = SKTexture.init(imageNamed: "Kerja_3")
        let f3 = SKTexture.init(imageNamed: "Kerja_4")
        let f4 = SKTexture.init(imageNamed: "Kerja_5")
        let frames: [SKTexture] = [f0, f1, f2, f3, f4, f3, f2, f1]
        
        // Change the frame per 0.2 sec
        let animation = SKAction.animate(with: frames, timePerFrame: 0.15)
        albertWork.run(SKAction.repeatForever(animation), withKey: "Key")
        
    }
    
}
