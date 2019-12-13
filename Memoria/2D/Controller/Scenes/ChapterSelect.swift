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
    let playPosition : CGFloat = 160
    var hapticIntensity : Float = 0.5
    var hapticSharpness : Float = 0.5
    
    let chapterName = [
        "",
        "Mémoire 1 ~ Emptiness",
        "Mémoire 2 ~ Journey",
        "Mémoire 3 ~ Breeze",
        "Mémoire 4 ~ Return",
        "Mémoire 5 ~ You",
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
    
    let back = SKSpriteNode()
    
    var playButton = YellowButton()
    
    let leftButton = SKSpriteNode(imageNamed: "CS_Left")
    let rightButton = SKSpriteNode(imageNamed: "CS_Right")
    
    var spriteManager = SpriteManager.instance
    
    override func didMove(to view: SKView) {
        addGesture(to : view)
        createPlayButton(for : view)
        
        chapterTitle.position = CGPoint(x: view.frame.width/2, y: 3*view.frame.height/4)
        chapterTitle.zPosition = 2
        chapterTitle.fontColor = .black
        chapterTitle.fontSize = 20
        chapterTitle.fontName = "Signika"
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
        back.run(SKAction.setTexture(SKTexture(imageNamed: "backButton"),resize: true))
        back.zPosition = 2
        back.position = CGPoint(x: 70, y: view.frame.height - 40)
        
        
        leftButton.name = "leftButton"
        leftButton.position = CGPoint(x: 200, y: view.frame.height/2)
        leftButton.zPosition = 2
        leftButton.alpha = 0
        
        rightButton.name = "rightButton"
        rightButton.position = CGPoint(x: view.frame.width - 200, y: view.frame.height/2)
        rightButton.zPosition = 2
        
        addChild(chapterTitle)
        addChild(chapterBox)
        addChild(dropShadowChapterBox)
        
        addChild(chapter1)
        addChild(whiteBorder)
        //
        addChild(back)
        //
        
        addChild(leftButton)
        addChild(rightButton)
        
        changeChapter()
        
    }
    
    func changeChapter(){
        if spriteManager.chapter != 0{
            
            let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (Timer) in
                self.nextChapter()
            }
        }
    }
    
    func createPlayButton(for view : SKView){
        let size = CGSize(width: 114.5, height: 49.5)
        playButton = YellowButton(with: size, text: "PLAY", textSize: 15)
        playButton.name = "play"
        playButton.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 160)
        addChild(playButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "play"{
                    playButton.highlight()
                }
                if node.name == "back"{
                    back.run(SKAction.setTexture(SKTexture(imageNamed: "backButtonSelected"),resize: true))
                }
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetButton()
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "play"{
                    HapticGenerator.instance.play(sharpnessValue : hapticSharpness, intensityValue : hapticIntensity)
                    switch state {
                    case 1: spriteManager.callScene(index: 1, transition: .fade(withDuration: 1))
                    case 2: break
                    case 3: break
                    case 4: break
                    case 5: break
                    default: break
                    }
                    playPlaySound()
                }
                else if node.name == "leftButton"{
                    HapticGenerator.instance.play(sharpnessValue : hapticSharpness, intensityValue : hapticIntensity)
                    prevChapter()
                    
                }
                else if node.name == "rightButton"{
                    HapticGenerator.instance.play(sharpnessValue : hapticSharpness, intensityValue : hapticIntensity)
                    nextChapter()
                    
                }
                else if node.name == "back"{
                    HapticGenerator.instance.play(sharpnessValue : hapticSharpness, intensityValue : hapticIntensity)
                    spriteManager.callScene(index: 100, transition: .fade(withDuration: 1))
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
    
    func rightArrowMove(alpha : CGFloat){
        let moveRightArrow = [SKAction.moveTo(x: view!.frame.width-170, duration: durationMove/3),SKAction.fadeAlpha(to: 0, duration: durationMove/3),SKAction.moveTo(x: view!.frame.width-200, duration: 0.3),SKAction.fadeAlpha(to:alpha, duration: durationMove/3)]
        rightButton.run(SKAction.sequence(moveRightArrow))
    }
    
    func leftArrowMove(alpha : CGFloat){
        let moveLeftArrow = [SKAction.moveTo(x: 170, duration: durationMove/3),SKAction.fadeAlpha(to: 0, duration: durationMove/3),SKAction.moveTo(x: 200, duration: 0.3),SKAction.fadeAlpha(to: alpha, duration: durationMove/3)]
        leftButton.run(SKAction.sequence(moveLeftArrow))
    }
    
    func fadeIn(node : SKNode){
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: durationMove)
        node.run(fadeIn)
    }
    
    func fadeOut(node : SKNode){
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: durationMove)
        node.run(fadeOut)
    }
    
    func nextChapter(){
        if state < 5 {
            removeChapters()
            chapterTitleChange()
            rightArrowMove(alpha : state == 4 ? 0 : 1)
        }
        switch state {
        case 1:
            chapterMoveNext(chapter1: chapter1, chapter2: chapter2)
            fadeIn(node : leftButton)
        case 2:
            chapterMoveNext(chapter1: chapter2, chapter2: chapter3)
        case 3:
            chapterMoveNext(chapter1: chapter3, chapter2: chapter4)
        case 4:
            chapterMoveNext(chapter1: chapter4, chapter2: chapter5)
        default:
            print(state)
        }
    }
    
    func prevChapter(){
        if state > 1 {
            removeChapters()
            chapterTitleChange()
            leftArrowMove(alpha : state == 2 ? 0 : 1)
        }
        switch state {
        case 2:
            chapterMovePrev(chapter1: chapter2, chapter2: chapter1)
        case 3:
            chapterMovePrev(chapter1: chapter3, chapter2: chapter2)
        case 4:
            chapterMovePrev(chapter1: chapter4, chapter2: chapter3)
        case 5:
            chapterMovePrev(chapter1: chapter5, chapter2: chapter4)
            fadeIn(node: rightButton)
        default:
            print(state)
        }
    }
    
    func chapterTitleChange(){
        chapterTitle.run(SKAction.fadeAlpha(to: 0, duration: durationMove/2))
        self.run(SKAction.wait(forDuration: durationMove/2)) {
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
        playNextSound()
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
            self.run(SKAction.wait(forDuration: durationMove)) {
                self.view!.isUserInteractionEnabled = true
            }
        }
    }
    
    func chapterMovePrev(chapter1: SKNode, chapter2: SKNode){
        playNextSound()
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
            self.run(SKAction.wait(forDuration: durationMove)) {
                self.view!.isUserInteractionEnabled = true
            }
        }
    }
    
    func resetButton(){
        playButton.reset()
        back.run(SKAction.setTexture(SKTexture(imageNamed: "backButton"),resize: true))
    }
    
    func playNextSound(){
        FirstPlayer.instance.playSound(for: part.chapterSelect, index: 1)
    }
    
    func playPlaySound(){
        FirstPlayer.instance.playSound(for: part.chapterSelect, index: 2)
    }
    
    override func willMove(from view: SKView) {
        SecondPlayer.instance.player?.setVolume(0, fadeDuration: 2)
        self.run(SKAction.wait(forDuration: 2)){
            SecondPlayer.instance.player?.stop()
        }
    }
}
