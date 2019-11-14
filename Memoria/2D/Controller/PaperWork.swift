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
    
    let backBlack = SKShapeNode(circleOfRadius: 30)
    
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
    let button = SKSpriteNode(imageNamed: "nextButton")
    
    let paperSize = CGSize(width: 300, height: 380)
    
    let fadeIn = SKAction.fadeIn(withDuration: 1.2)
    let fadeInSlow = SKAction.fadeIn(withDuration: 2)
    let fadeOut = SKAction.fadeOut(withDuration: 1.2)
    
    
    override func didMove(to view: SKView) {
        
        let Paper = SKTexture(imageNamed: "Kertas")
        let setPaper = SKAction.setTexture(Paper)
        
        albertWork.run(SKAction.setTexture(SKTexture(imageNamed: "Kerja_1")))
        albertWork.name = "Albert"
        albertWork.size = CGSize(width: view.frame.width, height: view.frame.height)
        albertWork.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        albertWork.zPosition = 1
        albertWork.alpha=0
        
        paper1_1.run(setPaper)
        paper1_1.name = "paper11"
        paper1_1.position = CGPoint(x: view.frame.width/5, y: view.frame.height/2)
        paper1_1.size = paperSize
        paper1_1.zPosition = 4
        paper1_1.alpha = 0
        
        paper1_2.run(setPaper)
        paper1_2.name = "paper12"
        paper1_2.position = CGPoint(x: view.frame.width/5+10, y: view.frame.height/2-10)
        paper1_2.size = paperSize
        paper1_2.zPosition = 3
        paper1_2.alpha = 0
        
        paper1_3.run(setPaper)
        paper1_3.name = "paper13"
        paper1_3.position = CGPoint(x: view.frame.width/5+15, y: view.frame.height/2-14)
        paper1_3.size = paperSize
        paper1_3.zPosition = 2
        paper1_3.alpha = 0
        
        paper2.name = "paper2"
        paper2.color = .white
        paper2.position = CGPoint(x: 4*view.frame.width/5, y: view.frame.height/2)
        paper2.size = paperSize
        paper2.zPosition = 2
        paper2.alpha = 0
        
        text11.size = paperSize
        text11.position = paper1_1.position
        text11.zPosition = 5
        text11.alpha = 0
        
        text12.size = paperSize
        text12.position = paper1_1.position
        text12.zPosition = 5
        text12.alpha = 0
    
        text13.size = paperSize
        text13.position = paper1_1.position
        text13.zPosition = 5
        text13.alpha = 0
        
        text21.size = paperSize
        text21.position = paper1_2.position
        text21.zPosition = 5
        text21.alpha = 0
        
        text22.size = paperSize
        text22.position = paper1_2.position
        text22.zPosition = 5
        text22.alpha = 0

        text31.size = paperSize
        text31.position = paper1_3.position
        text31.zPosition = 5
        text31.alpha = 0
        
        text32.size = paperSize
        text32.position = paper1_3.position
        text32.zPosition = 5
        text32.alpha = 0

        text33.size = paperSize
        text33.position = paper1_3.position
        text33.zPosition = 5
        text33.alpha = 0

        detector.name = "detector"
        detector.position = CGPoint(x: 4*view.frame.width/5, y: view.frame.height/2)
        detector.size = CGSize(width: view.frame.width/3, height: 4*view.frame.height/5)
        detector.zPosition = 0
        
        pen.anchorPoint = CGPoint(x: 0.38, y: 0.38)
        pen.position = paper2.position
        pen.name = "pen"
        pen.zPosition = 3
        pen.setScale(0.12)
        pen.alpha = 0
        
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.position = CGPoint(x:view.frame.width-60, y: 60)
        button.zPosition = 7
        button.name = "nextButton"
        button.setScale(0.4)
        
        backBlack.fillColor = .black
        backBlack.position = button.position
        backBlack.zPosition = 6
        
        addChild(detector)
        addChild(albertWork)
        
        addChild(paper1_1)
        addChild(paper1_2)
        addChild(paper1_3)
        addChild(paper2)
        
        albertWork.run(fadeIn)
        paper1_1.run(fadeIn)
        paper1_2.run(fadeIn)
        paper1_3.run(fadeIn)
        paper2.run(fadeIn)
        pen.run(fadeIn)
        
        addChild(pen)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)

                for node in nodesarray {
                    if node.name == "detector" {
                        startTouch = location
                        nodePosition = node.position
            
                        albertAnimation()
                    }
                        
                    else if node.name == "nextButton"{
                        let fourthPage = Office(fileNamed: "Office")
                        fourthPage?.scaleMode = .resizeFill
                        self.view?.presentScene(fourthPage!)
                    }
                }
            }

        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            let point1 = CGPoint(x: self.paper1_1.position.x - 100, y: view!.frame.height/2)
            let point2 = CGPoint(x: self.paper1_2.position.x - 100, y: view!.frame.height/2 - 10)
                
            let move1 = SKAction.move(to: point1, duration: 1)
            let move2 = SKAction.move(to: point2, duration: 1)
            
                if let touch = touches.first{
                    let touchLocation = touch.location(in: self)
                    if touchLocation.x < paper2.position.x - 100{
                        
                    }
                    else if touchLocation != startTouch{
                        print(touchLocation)
                        pen.position = touchLocation
                        HapticGenerator.instance.play(4)
                        
                        writeState += 1
                        if writeState == 5{
                            addChild(text11)
                            text11.run(fadeInSlow)
                        }
                        if writeState == 100{
                            addChild(text12)
                            text12.run(fadeInSlow)
                        }
                        if writeState == 200{
                            addChild(text13)
                            text13.run(fadeInSlow)
                        }
                        if writeState == 300{
                            self.paper1_1.run(move1)
                            self.text11.run(move1)
                            self.text12.run(move1)
                            self.text13.run(move1)
                            self.paper1_1.run(self.fadeOut)
                            self.text11.run(self.fadeOut)
                            self.text12.run(self.fadeOut)
                            self.text13.run(self.fadeOut)
                        }
                        if writeState == 400{
                            paper1_1.removeFromParent()
                            text11.removeFromParent()
                            text12.removeFromParent()
                            text13.removeFromParent()
                            addChild(text21)
                            text21.run(fadeInSlow)
                        }
                        if writeState == 500{
                            addChild(text22)
                            text22.run(fadeInSlow)
                        }

                        if writeState == 600{
                            self.paper1_2.run(move2)
                            self.text21.run(move2)
                            self.text22.run(move2)
                            self.paper1_2.run(self.fadeOut)
                            self.text21.run(self.fadeOut)
                            self.text22.run(self.fadeOut)
                        }
                        if writeState == 700{
                            paper1_2.removeFromParent()
                            text21.removeFromParent()
                            text22.removeFromParent()
                            addChild(text31)
                            text31.run(fadeInSlow)
                        }
                        if writeState == 800{
                            addChild(text32)
                            text32.run(fadeInSlow)
                        }
                        if writeState == 900{
                            addChild(text33)
                            text33.run(fadeInSlow)
                            
                            addChild(button)
                            addChild(backBlack)
                        }
                    }
                }
            
            super.touchesMoved(touches, with: event)
        }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        albertWork.removeAction(forKey: "Key")
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


