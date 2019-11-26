//
//  MainMenu.swift
//  Memoria
//
//  Created by Delvin on 08/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    var scroller : InfiniteScrollingBackground?
    
    
    override func didMove(to view: SKView) {
        let firstPage = MainMenu(fileNamed: "MainMenu")
        firstPage?.scaleMode = .aspectFill
        
        let gameTitle = SKLabelNode()
        let playButton = SKLabelNode()
        let backgroundImage = SKSpriteNode(imageNamed: "Main_Background")
        let baling = SKSpriteNode(imageNamed: "Baling")
        let langitBiru = SKSpriteNode(imageNamed: "Sora_Aoi")
        
        let dropShadowTitle = SKLabelNode()
        let dropShadowPlay = SKLabelNode()
        
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 1)
        let fadeInShadow = SKAction.fadeAlpha(to: 0.5, duration: 1)
        
        PlaySound.instance.playSound(for: part.mainMenu, index: 1)
        PlaySound.instance.player?.numberOfLoops = -1
        
        let images = [
            UIImage(named: "Awan")!,
            UIImage(named: "Awan")!,
        ]
        
        // Initializing InfiniteScrollingBackground's instance:
        scroller = InfiniteScrollingBackground(images: images,
                                               scene: self,
                                               scrollDirection: .left,
                                               transitionSpeed: 0.06) // from 0 to 100
        
        // Activating it:
        scroller?.scroll()
        
        // (Optional) Changing the instance's zPosition:
        scroller?.zPosition = -2
        
        gameTitle.fontColor = .white
        gameTitle.fontSize = 60
        gameTitle.fontName = "Roboto-Medium"
        gameTitle.text = "[ e l i o ]"
        gameTitle.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        gameTitle.zPosition = 2
        gameTitle.alpha = 0
        
        dropShadowTitle.fontColor = .black
        dropShadowTitle.fontSize = gameTitle.fontSize
        dropShadowTitle.fontName = gameTitle.fontName
        dropShadowTitle.text = gameTitle.text
        dropShadowTitle.position = CGPoint(x: view.frame.width/2 + 2, y: view.frame.height/2 - 2)
        dropShadowTitle.zPosition = 1
        dropShadowTitle.alpha = gameTitle.alpha
    
        playButton.fontColor = .white
        playButton.fontSize = 18
        playButton.fontName = "Roboto-Regular"
        playButton.text = "touch to start"
        playButton.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 110)
        playButton.zPosition = 2
        playButton.alpha = 0
        
        dropShadowPlay.fontColor = .black
        dropShadowPlay.fontSize = playButton.fontSize
        dropShadowPlay.fontName = playButton.fontName
        dropShadowPlay.text = playButton.text
        dropShadowPlay.position = CGPoint(x: view.frame.width/2 + 1, y: view.frame.height/2 - 111)
        dropShadowPlay.zPosition = 1
        dropShadowPlay.alpha = playButton.alpha
        
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
        
        addChild(langitBiru)
        addChild(backgroundImage)
        addChild(baling)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            gameTitle.run(fadeIn)
            self.addChild(gameTitle)
            self.addChild(dropShadowTitle)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dropShadowTitle.run(fadeInShadow)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            playButton.run(fadeIn)
            self.addChild(playButton)
            self.addChild(dropShadowPlay)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dropShadowPlay.run(fadeInShadow)
            }
        }

        baling.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 20)))
        
        let blinking = [SKAction.wait(forDuration: 3) ,SKAction.fadeAlpha(to: 0, duration: 1),SKAction.fadeAlpha(to: 1, duration: 1)]
        let blinkingShadow = [SKAction.wait(forDuration: 3) ,SKAction.fadeAlpha(to: 0, duration: 1),SKAction.fadeAlpha(to: 0.5, duration: 1)]
        playButton.run(SKAction.repeatForever(SKAction.sequence(blinking)))
        dropShadowPlay.run(SKAction.repeatForever(SKAction.sequence(blinkingShadow)))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)

            for node in nodesarray {
                if node.name == "bg"{
                    print("a")
                    SpriteManager.instance.callScene(index: 99, transition: .fade(withDuration: 1))
                }
            }
        }
    }
}