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
        
        let gameTitle = SKLabelNode()
        let playButton = SKLabelNode()
        let backgroundImage = SKSpriteNode(imageNamed: "Main Background")
//        let dropShadow = SKLabelNode()
        
        gameTitle.fontColor = .black
        gameTitle.fontSize = 52
        gameTitle.fontName = "Roboto-Medium"
        gameTitle.text = "Reverie"
        gameTitle.position = CGPoint(x: view.frame.width/2, y: 3*view.frame.height/4)
        gameTitle.zPosition = 2
        
        playButton.fontColor = .black
        playButton.fontSize = 30
        playButton.fontName = "Roboto-Regular"
        playButton.text = "Play"
        playButton.name = "playButton"
        playButton.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 30)
        playButton.zPosition = 2
        
//        dropShadow.fontSize = 30
//        dropShadow.fontName = playButton.fontName
//        dropShadow.text = playButton.text
//        dropShadow.fontColor = SKColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
//        dropShadow.position = CGPoint(x: view.frame.width/2 + 1, y: view.frame.height/2 - 32)
//        dropShadow.zPosition = 1
        
        backgroundImage.size = CGSize(width: view.frame.width, height: view.frame.height)
        backgroundImage.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        backgroundImage.zPosition = -1
        
//        addChild(dropShadow)\
        addChild(gameTitle)
        addChild(playButton)
        addChild(backgroundImage)
        
//        addBubble()
//        addChild(selectChapter)
    }
    
    func addBubble(){
        let text = ["> Used this answer, but Leo Dabus deserves credit.", "> Please comment if you can explain whether it's equally valid to define a new.", "> Convenience initializer as Leo did or override the default initializer as this answer does", "> or if one is preferable to the other."]
        let bubble = Bubble()
        let width : CGFloat = 400
        let position = CGPoint(x: frame.width/2, y: frame.height/2)
        bubble.createChoiceBubble(position: position, width: width, bubbleColor: .black, type: .upperLeft, choices: text, textColor: .yellow, textSize : 16)
        addChild(bubble)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)

            for node in nodesarray {
                if node.name == "playButton"{
                    let scene = SpriteManager.instance.callScene(index: 99)
                    view!.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                }
            }
        }
    }
}
