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
    
    let chapterName = [
    "",
    "Memoire 1 ~ Emptiness",
    "Memoire 2 ~ Journey",
    "Memoire 3 ~ Breeze",
    "Memoire 4 ~ Return/Home",
    "Memoire 5 ~ You",
    ]
    let chapterTitle = SKLabelNode()
    let dropShadowTitle = SKLabelNode()
    
    let chapter1 = SKSpriteNode(imageNamed: "House")
    let chapter2 = SKSpriteNode(imageNamed: "PH1")
    let chapter3 = SKSpriteNode(imageNamed: "PH2")
    let chapter4 = SKSpriteNode(imageNamed: "PH3")
    let chapter5 = SKSpriteNode(imageNamed: "PH4")
    
    let whiteBorder = SKSpriteNode(imageNamed: "CS_Brush")
    
    let durationMove = 1.0
    
    let back = SKSpriteNode(imageNamed: "nextButton")
    let backBlack = SKShapeNode(circleOfRadius: 30)
    
    let play = SKSpriteNode(imageNamed: "CS_Play")
    let leftButton = SKSpriteNode(imageNamed: "CS_Left")
    let rightButton = SKSpriteNode(imageNamed: "CS_Right")
    
    var spriteManager = SpriteManager.instance
    
    override func didMove(to view: SKView) {
        addGesture(to : view)
        
        chapterTitle.position = CGPoint(x: view.frame.width/2, y: 3*view.frame.height/4)
        chapterTitle.zPosition = 2
        chapterTitle.fontColor = .black
        chapterTitle.fontSize = 48
        chapterTitle.fontName = "Roboto-Medium"
        chapterTitle.name = "Chapter Name"
        chapterTitle.text = chapterName[1]
        
        dropShadowTitle.position = CGPoint(x: view.frame.width/2 + 2, y: 3*view.frame.height/4 - 2)
        dropShadowTitle.zPosition = chapterTitle.zPosition - 0.1
        dropShadowTitle.fontColor = .black
        dropShadowTitle.fontSize = chapterTitle.fontSize
        dropShadowTitle.fontName = chapterTitle.fontName
        dropShadowTitle.name = "Chapter Shadow"
        dropShadowTitle.text = chapterName[1]
        dropShadowTitle.alpha = 0.5
        
        chapter1.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        chapter1.size = CGSize(width: view.frame.width, height: view.frame.height)
        chapter1.zPosition = -1
        
        chapter2.position = CGPoint(x: 3 * view.frame.width/4, y: view.frame.height/2)
        chapter2.size = chapter1.size
        chapter2.zPosition = -1
        chapter2.alpha = 0
        
        chapter3.position = CGPoint(x: 3 * view.frame.width/4, y: view.frame.height/2)
        chapter3.size = chapter1.size
        chapter3.zPosition = -1
        chapter3.alpha = 0
    
        chapter4.position = CGPoint(x: 3 * view.frame.width/4, y: view.frame.height/2)
        chapter4.size = chapter1.size
        chapter4.zPosition = -1
        chapter4.alpha = 0
        
        chapter5.position = CGPoint(x: 3 * view.frame.width/4, y: view.frame.height/2)
        chapter5.size = chapter1.size
        chapter5.zPosition = -1
        chapter5.alpha = 0
        
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
        
        play.name = "play"
        play.zPosition = 1
        play.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 150)
        
        leftButton.name = "leftButton"
        leftButton.position = CGPoint(x: 75, y: view.frame.height/2)
        leftButton.zPosition = 2
        
        rightButton.name = "rightButton"
        rightButton.position = CGPoint(x: view.frame.width-75, y: view.frame.height/2)
        rightButton.zPosition = 2
        
        addChild(chapterTitle)
        addChild(dropShadowTitle)
        
        addChild(chapter1)
        addChild(whiteBorder)
        
        addChild(back)
        addChild(backBlack)
        
        addChild(play)
        
        addChild(leftButton)
        addChild(rightButton)
        
        let moveRightArrow = [SKAction.wait(forDuration: 2),SKAction.moveTo(x: view.frame.width-52, duration: 1),SKAction.fadeAlpha(to: 0, duration: 1),SKAction.moveTo(x: view.frame.width-75, duration: 0.5),SKAction.fadeAlpha(to: 1, duration: 1)]
        let moveLeftArrow = [SKAction.wait(forDuration: 2),SKAction.moveTo(x: 52, duration: 1),SKAction.fadeAlpha(to: 0, duration: 1),SKAction.moveTo(x: 75, duration: 0.5),SKAction.fadeAlpha(to: 1, duration: 1)]
        leftButton.run(SKAction.repeatForever(SKAction.sequence(moveLeftArrow)))
        rightButton.run(SKAction.repeatForever(SKAction.sequence(moveRightArrow)))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
    if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)

            for node in nodesarray {
                if node.name == "play"{
                    print(state)
                    switch state {
                    case 1:
                        let scene = SpriteManager.instance.callScene(index: 1)
                        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                        PlaySound.instance.player?.stop()
                    case 2:
                        let scene = SpriteManager.instance.callScene(index: 2)
                        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
                        PlaySound.instance.player?.stop()
                    case 3:
                        let scene = SpriteManager.instance.callScene(index: 3)
                        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
                        PlaySound.instance.player?.stop()
                    case 4:
                        PlaySound.instance.player?.stop()
                    case 5:
                        PlaySound.instance.player?.stop()
                    default:
                        PlaySound.instance.player?.stop()
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
    
    func addGesture(to view: SKView){
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedLeft(sender:)))
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedRight(sender:)))
            
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc func swipedLeft(sender: UISwipeGestureRecognizer){
        nextChapter()
    }
    
    @objc func swipedRight(sender: UISwipeGestureRecognizer){
        prevChapter()
    }
    
    func nextChapter(){
        switch state {
        case 1:
            removeChapters()
            chapterMoveNext(chapter1: chapter1, chapter2: chapter2)
            chapterTitle.text = chapterName[state]
            dropShadowTitle.text = chapterName[state]
        case 2:
            removeChapters()
            chapterMoveNext(chapter1: chapter2, chapter2: chapter3)
            chapterTitle.text = chapterName[state]
            dropShadowTitle.text = chapterName[state]
        case 3:
            removeChapters()
            chapterMoveNext(chapter1: chapter3, chapter2: chapter4)
            chapterTitle.text = chapterName[state]
            dropShadowTitle.text = chapterName[state]
        case 4:
            removeChapters()
            chapterMoveNext(chapter1: chapter4, chapter2: chapter5)
            chapterTitle.text = chapterName[state]
            dropShadowTitle.text = chapterName[state]
        default:
            print(state)
        }
    }
    
    func prevChapter(){
        switch state {
        case 2:
            removeChapters()
            chapterMovePrev(chapter1: chapter2, chapter2: chapter1)
            chapterTitle.text = chapterName[state]
            dropShadowTitle.text = chapterName[state]
        case 3:
            removeChapters()
            chapterMovePrev(chapter1: chapter3, chapter2: chapter2)
            chapterTitle.text = chapterName[state]
            dropShadowTitle.text = chapterName[state]
        case 4:
            removeChapters()
            chapterMovePrev(chapter1: chapter4, chapter2: chapter3)
            chapterTitle.text = chapterName[state]
            dropShadowTitle.text = chapterName[state]
        case 5:
            removeChapters()
            chapterMovePrev(chapter1: chapter5, chapter2: chapter4)
            chapterTitle.text = chapterName[state]
            dropShadowTitle.text = chapterName[state]
        default:
            print(state)
        }
    }
    
    func removeChapters(){
        chapter1.removeFromParent()
        chapter2.removeFromParent()
        chapter3.removeFromParent()
        chapter4.removeFromParent()
        chapter5.removeFromParent()
    }
    
    func chapterMoveNext(chapter1: SKNode, chapter2: SKNode){
        addChild(chapter1)
        addChild(chapter2)

        let point1 = CGPoint(x: chapter1.position.x - self.view!.frame.width/4, y: view!.frame.height/2)
        let point2 = CGPoint(x: chapter2.position.x - self.view!.frame.width/4, y: view!.frame.height/2)

        let move1 = SKAction.move(to: point1, duration: durationMove)
        move1.timingMode = SKActionTimingMode.easeInEaseOut
        let move2 = SKAction.move(to: point2, duration: durationMove)
        move2.timingMode = SKActionTimingMode.easeInEaseOut

        if self.state < 5{
            chapter1.run(move1)
            chapter2.run(move2)
            
            chapter1.run(SKAction.fadeAlpha(to: 0, duration: durationMove))
            chapter2.run(SKAction.fadeAlpha(to: 1, duration: durationMove))
            self.state += 1
            view!.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + durationMove) {
                self.view!.isUserInteractionEnabled = true
            }
        }
    }
    
    func chapterMovePrev(chapter1: SKNode, chapter2: SKNode){
        addChild(chapter1)
        addChild(chapter2)

        let point1 = CGPoint(x: chapter1.position.x + self.view!.frame.width/4, y: view!.frame.height/2)
        let point2 = CGPoint(x: chapter2.position.x + self.view!.frame.width/4, y: view!.frame.height/2)

        let move1 = SKAction.move(to: point1, duration: durationMove)
        move1.timingMode = SKActionTimingMode.easeInEaseOut
        let move2 = SKAction.move(to: point2, duration: durationMove)
        move2.timingMode = SKActionTimingMode.easeInEaseOut

        if self.state > 1{
            chapter1.run(move1)
            chapter2.run(move2)
        
            chapter1.run(SKAction.fadeAlpha(to: 0, duration: durationMove))
            chapter2.run(SKAction.fadeAlpha(to: 1, duration: durationMove))
            self.state -= 1
            view!.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + durationMove) {
                self.view!.isUserInteractionEnabled = true
            }
        }
    }
}
