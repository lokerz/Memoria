//
//  PaperWork.swift
//  Memoria
//
//  Created by Delvin on 01/11/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class PaperWork: SKScene {

    var statePaper = 1
    
    private var currentNode: SKNode?
    var nodePosition = CGPoint()
    var startTouch = CGPoint()
    
    let albertWork = SKSpriteNode(imageNamed: "Kerja")
    let pen = SKSpriteNode()
    let paper1 = SKSpriteNode()
    let paper2 = SKSpriteNode()
    let detector = SKSpriteNode()
    let button = SKSpriteNode(imageNamed: "nextButton")
    
    let fadeIn = SKAction.fadeIn(withDuration: 1.2)
    let fadeOut = SKAction.fadeOut(withDuration: 1.2)
    
    override func didMove(to view: SKView) {
        
        pen.name = "pen"
        pen.size = CGSize(width: 50, height: 50)
        pen.zPosition = 3
        pen.color = .red
        
        albertWork.name = "Albert"
        albertWork.size = CGSize(width: view.frame.width-100, height: view.frame.height)
        albertWork.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        albertWork.zPosition = 1
        albertWork.alpha=0
        
        paper1.name = "paper1"
        paper1.position = CGPoint(x: view.frame.width/5, y: view.frame.height/2)
        paper1.size = CGSize(width: view.frame.width/3, height: 4*view.frame.height/5)
        paper1.zPosition = 2
        paper1.color = .red
        paper1.alpha = 0
        
        paper2.name = "paper2"
        paper2.position = CGPoint(x: 4*view.frame.width/5, y: view.frame.height/2)
        paper2.size = CGSize(width: view.frame.width/3, height: 4*view.frame.height/5)
        paper2.zPosition = 2
        paper2.color = .blue
        paper2.alpha = 0
        
        detector.name = "detector"
        detector.position = CGPoint(x: 4*view.frame.width/5, y: view.frame.height/2)
        detector.size = CGSize(width: view.frame.width/3, height: 4*view.frame.height/5)
        detector.zPosition = 0
        
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.position = CGPoint(x:view.frame.width-60, y: 60)
        button.zPosition = 3
        button.name = "nextButton"
        button.setScale(0.4)
        
        addChild(detector)
        addChild(albertWork)
        addChild(paper1)
        addChild(paper2)
        albertWork.run(fadeIn)
        paper1.run(fadeIn)
        paper2.run(fadeIn)
        
        addChild(button)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)

                for node in nodesarray {
                    print(node.name)
                    if node.name == "detector" {
                        startTouch = location
                        nodePosition = node.position
                        statePaper = 1
                    }
                    else if node.name == "paper1" || node.name == "Albert"{
                        statePaper = 2
                    }
                    else if node.name == "nextButton"{
                        let fourthPage = Office(fileNamed: "Office")
                        fourthPage?.scaleMode = .resizeFill
                        self.view?.presentScene(fourthPage!, transition: SKTransition.fade(withDuration: 0.5))
                    }
                }
            }

        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first{
                    let touchLocation = touch.location(in: self)
                    print(statePaper)
                    print(startTouch)
                    print(touchLocation)
                    
                    if touchLocation != startTouch && statePaper == 1{
                        paper1.color = .black
//                        pen.position = touchLocation
                    }
                }
        }

}


