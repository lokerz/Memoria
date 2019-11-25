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
//    let dropShadowTitle = SKLabelNode()
    
    let chapterBox = SKShapeNode(rectOf: CGSize(width: 400, height: 65))
    let dropShadowChapterBox = SKShapeNode(rectOf: CGSize(width: 400, height: 65))
    
    let chapter1 = SKSpriteNode(imageNamed: "House")
    let chapter2 = SKSpriteNode(imageNamed: "PH1")
    let chapter3 = SKSpriteNode(imageNamed: "PH2")
    let chapter4 = SKSpriteNode(imageNamed: "PH3")
    let chapter5 = SKSpriteNode(imageNamed: "PH4")
    
    let whiteBorder = SKSpriteNode(imageNamed: "CS_Brush_Circle")
    
    let durationMove = 1.0
    
    let back = SKSpriteNode(imageNamed: "backButton")
    
    let playText = SKLabelNode()
    let playBox = SKShapeNode(rectOf: CGSize(width: 114.5, height: 49.5))
    let dropShadowPlayBox = SKShapeNode(rectOf: CGSize(width: 114.5, height: 49.5))
    
    let leftButton = SKSpriteNode(imageNamed: "CS_Left")
    let rightButton = SKSpriteNode(imageNamed: "CS_Right")
    
    var spriteManager = SpriteManager.instance
    
    override func didMove(to view: SKView) {
        addGesture(to : view)
        
        chapterTitle.position = CGPoint(x: view.frame.width/2, y: 3*view.frame.height/4)
        chapterTitle.zPosition = 2
        chapterTitle.fontColor = .black
        chapterTitle.fontSize = 20
        chapterTitle.fontName = "Roboto-Light"
        chapterTitle.name = "Chapter Name"
        chapterTitle.text = chapterName[1]
        
        chapterBox.name = "box"
        chapterBox.fillColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        chapterBox.zPosition = 1
        chapterBox.position = CGPoint(x: view.frame.width/2, y: 3*view.frame.height/4 + 10)
        chapterBox.strokeColor = .black
        
        dropShadowChapterBox.fillColor = .black
        dropShadowChapterBox.zPosition = 0.9
        dropShadowChapterBox.position = CGPoint(x: view.frame.width/2 + 5, y: 3*view.frame.height/4 + 5)
        dropShadowChapterBox.strokeColor = .clear
            
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
        back.zPosition = 2
        back.position = CGPoint(x: 70, y: view.frame.height - 40)
        
        playText.text = "PLAY"
        playText.fontName = "Roboto-Medium"
        playText.fontColor = .black
        playText.fontSize = 14
        playText.zPosition = 3
        playText.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 157)
        
        playBox.fillColor = UIColor.init(red: 255/255, green: 229/255, blue: 139/255, alpha: 1)
        playBox.zPosition = 2
        playBox.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 150)
        playBox.strokeColor = .black
        
        dropShadowPlayBox.zPosition = 1
        dropShadowPlayBox.fillColor = .black
        dropShadowPlayBox.strokeColor = .clear
        dropShadowPlayBox.position = CGPoint(x: view.frame.width/2 + 5, y: view.frame.height/2 - 155)
        
        leftButton.name = "leftButton"
        leftButton.position = CGPoint(x: 200, y: view.frame.height/2)
        leftButton.zPosition = 2
        
        rightButton.name = "rightButton"
        rightButton.position = CGPoint(x: view.frame.width - 200, y: view.frame.height/2)
        rightButton.zPosition = 2
        
        addChild(chapterTitle)
        addChild(chapterBox)
        addChild(dropShadowChapterBox)
        
        addChild(chapter1)
        addChild(whiteBorder)
        
        addChild(back)
        
        addChild(playText)
        addChild(playBox)
        addChild(dropShadowPlayBox)
        
        addChild(leftButton)
        addChild(rightButton)
        
        let moveRightArrow = [SKAction.wait(forDuration: 2),SKAction.moveTo(x: view.frame.width-180, duration: 1),SKAction.fadeAlpha(to: 0, duration: 1),SKAction.moveTo(x: view.frame.width-200, duration: 0.5),SKAction.fadeAlpha(to: 1, duration: 1)]
        let moveLeftArrow = [SKAction.wait(forDuration: 2),SKAction.moveTo(x: 180, duration: 1),SKAction.fadeAlpha(to: 0, duration: 1),SKAction.moveTo(x: 200, duration: 0.5),SKAction.fadeAlpha(to: 1, duration: 1)]
        leftButton.run(SKAction.repeatForever(SKAction.sequence(moveLeftArrow)))
        rightButton.run(SKAction.repeatForever(SKAction.sequence(moveRightArrow)))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
                        let scene = SpriteManager.instance.callScene(index: 6)
                        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
                        PlaySound.instance.player?.stop()
                    case 3:
                        let scene = SpriteManager.instance.callScene(index: 5)
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
            chapterTitleChange()
        case 2:
            removeChapters()
            chapterMoveNext(chapter1: chapter2, chapter2: chapter3)
            chapterTitleChange()
        case 3:
            removeChapters()
            chapterMoveNext(chapter1: chapter3, chapter2: chapter4)
            chapterTitleChange()
        case 4:
            removeChapters()
            chapterMoveNext(chapter1: chapter4, chapter2: chapter5)
            chapterTitleChange()
        default:
            print(state)
        }
    }
    
    func prevChapter(){
        switch state {
        case 2:
            removeChapters()
            chapterMovePrev(chapter1: chapter2, chapter2: chapter1)
            chapterTitleChange()
        case 3:
            removeChapters()
            chapterMovePrev(chapter1: chapter3, chapter2: chapter2)
            chapterTitleChange()
        case 4:
            removeChapters()
            chapterMovePrev(chapter1: chapter4, chapter2: chapter3)
            chapterTitleChange()
        case 5:
            removeChapters()
            chapterMovePrev(chapter1: chapter5, chapter2: chapter4)
            chapterTitleChange()
        default:
            print(state)
        }
    }
    
    func chapterTitleChange(){
        chapterTitle.run(SKAction.fadeAlpha(to: 0, duration: durationMove/2))
        DispatchQueue.main.asyncAfter(deadline: .now() + durationMove/2) {
            self.chapterTitle.text = self.chapterName[self.state]
            self.chapterTitle.run(SKAction.fadeAlpha(to: 1, duration: self.durationMove/2))
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
