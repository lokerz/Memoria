//
//  MainMenu.swift
//  Memoria
//
//  Created by Delvin on 08/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    
    override func didMove(to view: SKView) {
        let firstPage = MainMenu(fileNamed: "MainMenu")
        firstPage?.scaleMode = .aspectFill
        
        let playButton = SKLabelNode()
        let backgroundImage = SKSpriteNode(imageNamed: "Main Background")
//        let selectChapter = SKLabelNode()
        let dropShadow = SKLabelNode()
        
        playButton.fontSize = 30
        playButton.fontName = "Helvetica Neue Medium"
        playButton.text = "Play"
        playButton.name = "playButton"
        playButton.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 30)
        playButton.zPosition = 2
        
        dropShadow.fontSize = 30
        dropShadow.fontName = playButton.fontName
        dropShadow.text = playButton.text
        dropShadow.fontColor = SKColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        dropShadow.position = CGPoint(x: view.frame.width/2 + 1, y: view.frame.height/2 - 32)
        dropShadow.zPosition = 1
        
//        selectChapter.fontSize = 30
//        selectChapter.fontName = "Helvetica Neue Medium"
//        selectChapter.text = "Chapter"
//        selectChapter.name = "selectChapter"
//        selectChapter.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 75)
//        selectChapter.zPosition = 2
        
        backgroundImage.size = CGSize(width: view.frame.width, height: view.frame.height)
        backgroundImage.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        backgroundImage.zPosition = -1
        
        addChild(dropShadow)
        addChild(playButton)
        addChild(backgroundImage)
        
//        addChild(selectChapter)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)

            for node in nodesarray {
                if node.name == "playButton"{
                    let nextPage = ChapterSelect(fileNamed: "ChapterSelect")
                    nextPage?.scaleMode = .resizeFill
                    self.view?.presentScene(nextPage!, transition: SKTransition.fade(withDuration: 0.5))
                }
//                else if node.name == "chapterSelect"{
//                    let nextPage = ChapterSelect(fileNamed: "ChapterSelect")
//                        nextPage?.scaleMode = .resizeFill
//                    self.view?.presentScene(nextPage!, transition: SKTransition.fade(withDuration: 0.5))
//                }
            }
        }
    }
}
