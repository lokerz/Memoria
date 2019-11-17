//
//  ChapterSelect.swift
//  Memoria
//
//  Created by Delvin on 08/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import SpriteKit

class ChapterSelect: SKScene {
    var state = 1
    
    let chapter1 = SKSpriteNode(imageNamed: "House")
    let chapter2 = SKSpriteNode(imageNamed: "PH1")
    let chapter3 = SKSpriteNode(imageNamed: "PH2")
    let chapter4 = SKSpriteNode(imageNamed: "PH3")
    let chapter5 = SKSpriteNode(imageNamed: "PH4")
    
    let whiteBorder = SKSpriteNode(imageNamed: "White")
    
    let durationMove = 0.6
    
    let back = SKSpriteNode(imageNamed: "nextButton")
    let backBlack = SKShapeNode(circleOfRadius: 30)
    
    let playButton = SKSpriteNode()
    let play = SKLabelNode()
    let leftButton = SKSpriteNode()
    let rightButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedLeft(sender:)))
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedRight(sender:)))
            
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        chapter1.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        chapter1.size = CGSize(width: view.frame.width, height: view.frame.height)
        chapter1.zPosition = -1
        
        chapter2.position = CGPoint(x: 3 * view.frame.width/2, y: view.frame.height/2)
        chapter2.size = chapter1.size
        chapter2.zPosition = -1
        
        chapter3.position = CGPoint(x: 5 * view.frame.width/2, y: view.frame.height/2)
        chapter3.size = chapter1.size
        chapter3.zPosition = -1
    
        chapter4.position = CGPoint(x: 7 * view.frame.width/2, y: view.frame.height/2)
        chapter4.size = chapter1.size
        chapter4.zPosition = -1
        
        chapter5.position = CGPoint(x: 9 * view.frame.width/2, y: view.frame.height/2)
        chapter5.size = chapter1.size
        chapter5.zPosition = -1
        
        whiteBorder.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        whiteBorder.zPosition = 0
        whiteBorder.size = chapter1.size
        
        back.name = "back"
        back.xScale = -1.0
        back.zPosition = 2
        back.position = CGPoint(x: 50, y: view.frame.height - 50)
        back.setScale(0.4)
        
        backBlack.fillColor = .black
        backBlack.position = back.position
        backBlack.zPosition = 1
        
        play.zPosition = 2
        play.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 150)
        play.text = "Play"
        
        playButton.name = "playButton"
        playButton.position = play.position
        playButton.size = CGSize(width: 200, height: 50)
        playButton.color = .black
        playButton.zPosition = 1
        
        leftButton.name = "leftButton"
        leftButton.position = CGPoint(x: 50, y: view.frame.height/2)
        leftButton.size = CGSize(width: 50, height: 50)
        leftButton.color = .black
        leftButton.zPosition = 2
        
        rightButton.name = "rightButton"
        rightButton.position = CGPoint(x: view.frame.width-50, y: view.frame.height/2)
        rightButton.size = CGSize(width: 50, height: 50)
        rightButton.color = .black
        rightButton.zPosition = 2
        
        addChild(chapter1)
        addChild(chapter2)
        addChild(chapter3)
        addChild(chapter4)
        addChild(chapter5)
        addChild(whiteBorder)
        
        addChild(back)
        addChild(backBlack)
        
        addChild(play)
        addChild(playButton)
        
        addChild(leftButton)
        addChild(rightButton)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)

            for node in nodesarray {
                if node.name == "playButton"{
                    switch state {
                    case 1:
                        let scene = SpriteManager.instance.callScene(index: 1)
                        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                    case 2:
                        let scene = SpriteManager.instance.callScene(index: 2)
                        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
                    case 3:
                        break
                    case 4:
                        break
                    case 5:
                        break
                    default:
                        break
                    }
                }
                else if node.name == "leftButton"{
                    prevChapter()
                    
                }
                else if node.name == "rightButton"{
                   nextChapter()
                    
                }
                else if node.name == "back"{
                    let scene = SpriteManager.instance.callScene(index: 100)
                          self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                }
            }
        }
    }
    
    @objc func swipedLeft(sender: UISwipeGestureRecognizer){
        nextChapter()
    }
    
    @objc func swipedRight(sender: UISwipeGestureRecognizer){
        prevChapter()
    }
    
    func nextChapter(){
        let point1 = CGPoint(x: self.chapter1.position.x - self.view!.frame.width, y: view!.frame.height/2)
        let point2 = CGPoint(x: self.chapter2.position.x - self.view!.frame.width, y: view!.frame.height/2)
        let point3 = CGPoint(x: self.chapter3.position.x - self.view!.frame.width, y: view!.frame.height/2)
        let point4 = CGPoint(x: self.chapter4.position.x - self.view!.frame.width, y: view!.frame.height/2)
        let point5 = CGPoint(x: self.chapter5.position.x - self.view!.frame.width, y: view!.frame.height/2)
        
        let move1 = SKAction.move(to: point1, duration: durationMove)
        let move2 = SKAction.move(to: point2, duration: durationMove)
        let move3 = SKAction.move(to: point3, duration: durationMove)
        let move4 = SKAction.move(to: point4, duration: durationMove)
        let move5 = SKAction.move(to: point5, duration: durationMove)
            if self.state < 5{
                chapter1.run(move1)
                chapter2.run(move2)
                chapter3.run(move3)
                chapter4.run(move4)
                chapter5.run(move5)
                    self.state += 1
                    view!.isUserInteractionEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + durationMove) {
                        self.view!.isUserInteractionEnabled = true
                }
        }
    }
    
    func prevChapter(){
        let point1 = CGPoint(x: self.chapter1.position.x + self.view!.frame.width, y: view!.frame.height/2)
        let point2 = CGPoint(x: self.chapter2.position.x + self.view!.frame.width, y: view!.frame.height/2)
        let point3 = CGPoint(x: self.chapter3.position.x + self.view!.frame.width, y: view!.frame.height/2)
        let point4 = CGPoint(x: self.chapter4.position.x + self.view!.frame.width, y: view!.frame.height/2)
        let point5 = CGPoint(x: self.chapter5.position.x + self.view!.frame.width, y: view!.frame.height/2)
            
        let move1 = SKAction.move(to: point1, duration: durationMove)
        let move2 = SKAction.move(to: point2, duration: durationMove)
        let move3 = SKAction.move(to: point3, duration: durationMove)
        let move4 = SKAction.move(to: point4, duration: durationMove)
        let move5 = SKAction.move(to: point5, duration: durationMove)
            if self.state > 1{
                chapter1.run(move1)
                chapter2.run(move2)
                chapter3.run(move3)
                chapter4.run(move4)
                chapter5.run(move5)
                    self.state -= 1
                    view!.isUserInteractionEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + durationMove) {
                        self.view!.isUserInteractionEnabled = true
            }
        }
    }
    
    override func willMove(from view: SKView) {
        for gesture in view.gestureRecognizers!{
            view.removeGestureRecognizer(gesture)
        }
    }
}
