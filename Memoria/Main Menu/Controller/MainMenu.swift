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
        let selectChapter = SKLabelNode()
        
        playButton.text = "Play"
        playButton.name = "playButton"
        playButton.color = .white
        playButton.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        
        selectChapter.text = "Chapter"
        selectChapter.name = "selectChapter"
        selectChapter.color = .white
        selectChapter.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 + 100)
        
        backgroundImage.size = CGSize(width: view.frame.width, height: view.frame.height)
        backgroundImage.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        backgroundImage.zPosition = -1
        
        addChild(playButton)
        addChild(backgroundImage)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)

            for node in nodesarray {
                if node.name == "playButton"{
                    let nextPage = MobilScene(fileNamed: "MobilScene")
                    nextPage?.scaleMode = .resizeFill
                    self.view?.presentScene(nextPage!, transition: SKTransition.fade(withDuration: 0.5))
                }
                else if node.name == "chapterSelect"{
                    let nextPage = ChapterSelect(fileNamed: "ChapterSelect")
                        nextPage?.scaleMode = .resizeFill
                    self.view?.presentScene(nextPage!, transition: SKTransition.fade(withDuration: 0.5))
                }
            }
        }
    }
}
