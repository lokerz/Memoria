//
//  MainMenu.swift
//  Memoria
//
//  Created by Delvin on 08/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    let title = "[ e l i o ]"
    
    var scroller : InfiniteScrollingBackground?
    let spriteManager = SpriteManager.instance
    
    let gameTitle = SKLabelNode()
    let playButton = SKLabelNode()
    let backgroundImage = SKSpriteNode(imageNamed: "Main_Background")
    let baling = SKSpriteNode(imageNamed: "Baling")
    let langitBiru = SKSpriteNode(imageNamed: "Sora_Aoi")
    
    let dropShadowTitle = SKLabelNode()
    let dropShadowPlay = SKLabelNode()
    
    let images = [
        UIImage(named: "Awan")!,
        UIImage(named: "Awan")!,
    ]
    
    override func didMove(to view: SKView) {
        let firstPage = MainMenu(fileNamed: "MainMenu")
        firstPage?.scaleMode = .aspectFill
        view.isUserInteractionEnabled = false

        playSound()
        playScroll()
        setupObjects(view : view)
        fadeInTitle()
        
        addChild(gameTitle)
        addChild(dropShadowTitle)
        addChild(langitBiru)
        addChild(backgroundImage)
        addChild(baling)
        addChild(playButton)
        addChild(dropShadowPlay)
        
    }
    
    func setupObjects(view : SKView){
        gameTitle.fontColor = .white
        gameTitle.fontSize = 60
        gameTitle.fontName = "Roboto-Medium"
        gameTitle.text = title
        gameTitle.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 15)
        gameTitle.zPosition = 2
        gameTitle.alpha = 0
        
        dropShadowTitle.fontColor = .black
        dropShadowTitle.fontSize = gameTitle.fontSize
        dropShadowTitle.fontName = gameTitle.fontName
        dropShadowTitle.text = gameTitle.text
        dropShadowTitle.position = CGPoint(x: view.frame.width/2 + 2, y: view.frame.height/2 - 2 - 15)
        dropShadowTitle.zPosition = 1
        dropShadowTitle.alpha = gameTitle.alpha
        
        playButton.fontColor = .white
        playButton.fontSize = 20
        playButton.fontName = "Roboto-Regular"
        playButton.text = "tap anywhere to start"
        playButton.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 100)
        playButton.zPosition = 2
        playButton.alpha = 0
        let blinking = [SKAction.wait(forDuration: 1), SKAction.fadeAlpha(to: 1, duration: 1.5), SKAction.wait(forDuration: 1) , SKAction.fadeAlpha(to: 0, duration: 1.5)]
        playButton.run(SKAction.repeatForever(SKAction.sequence(blinking)))
        
        dropShadowPlay.fontColor = .black
        dropShadowPlay.fontSize = playButton.fontSize
        dropShadowPlay.fontName = playButton.fontName
        dropShadowPlay.text = playButton.text
        dropShadowPlay.position = CGPoint(x: view.frame.width/2 + 1, y: view.frame.height/2 - 100 - 1)
        dropShadowPlay.zPosition = 1
        dropShadowPlay.alpha = 0
        let blinkingShadow = [SKAction.wait(forDuration: 1), SKAction.fadeAlpha(to: 0.5, duration: 1.5), SKAction.wait(forDuration: 1) , SKAction.fadeAlpha(to: 0, duration: 1.5)]
        dropShadowPlay.run(SKAction.repeatForever(SKAction.sequence(blinkingShadow)))

        backgroundImage.name = "bg"
        backgroundImage.size = CGSize(width: view.frame.width, height: view.frame.height)
        backgroundImage.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        backgroundImage.zPosition = -1
        
        langitBiru.size = backgroundImage.size
        langitBiru.position = backgroundImage.position
        langitBiru.zPosition = -3
        
        baling.zPosition = 0
        baling.position = CGPoint(x: 323, y: 255)
        baling.setScale(1/2)
        baling.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 20)))
    }
    
    func fadeInTitle(){
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 1)
        let fadeInShadow = SKAction.fadeAlpha(to: 0.5, duration: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.66) {
            self.gameTitle.run(fadeIn)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dropShadowTitle.run(fadeInShadow)
                self.view?.isUserInteractionEnabled = true
            }
        }
    }
    
    func playSound(){
        let random = Int.random(in: 1...5)
        
        SecondPlayer.instance.playSound(for: part.mainMenu, index: random, volume: 1.0)
        SecondPlayer.instance.player?.numberOfLoops = -1
    }
    
    func playScroll(){
        // Initializing InfiniteScrollingBackground's instance:
        scroller = InfiniteScrollingBackground(images: images,
                                               scene: self,
                                               scrollDirection: .left,
                                               transitionSpeed: 0.06) // from 0 to 100
        // Activating it:
        scroller?.scroll()
        
        // (Optional) Changing the instance's zPosition:
        scroller?.zPosition = -2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        HapticGenerator.instance.play(sharpnessValue: 0.5, intensityValue: 0.5)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "bg"{
                    HapticGenerator.instance.play(sharpnessValue: 0.5, intensityValue: 0.5)
                    spriteManager.callScene(index: 99, transition: .fade(withDuration: 3))
                    break
                }
            }
        }
    }
}
