//
//  EndingOne.swift
//  Memoria
//
//  Created by Delvin on 14/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import SpriteKit

class EndingOne: SKScene {
    
    var ending = SKSpriteNode()
    var endingFoto = SKSpriteNode()
    
    let monologues = [
        "Lost without direction...",
        "trapped in inhibition...",
        "In this stagnant life...",
        "what do you live for?",
        "I am elio",
    ]
    
    var sequences = [SKAction]()
    let fadeIn = SKAction.fadeIn(withDuration: 3)
    let fadeOut = SKAction.fadeOut(withDuration: 3)

    
    var isClickable = false
    
    override func didMove(to view: SKView) {
        playSound()
        
        ending = addImage(to: view, name: "endingOne")
        ending.alpha = 0
        ending.run(fadeIn.easeInOut()){
            self.isClickable = true
        }
        
        endingFoto = addImage(to: view, name: "endingFoto")
        endingFoto.alpha = 0
        
        
    }
    
    func addImage(to view : SKView, name : String) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: name)
        node.name = name
        node.size = view.frame.size
        node.position = view.center
        addChild(node)
        return(node)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
            for node in nodesarray {
                if node.name == "endingOne" && isClickable{
                    HapticGenerator.instance.play(sharpnessValue : 0.5, intensityValue : 0.5)
                    isClickable = false
                    ending.run(fadeOut.easeInOut()){
                        self.endingFoto.run(self.fadeIn.easeInOut()){
                            self.isClickable = true
                        }
                    }
                } else if node.name == "endingFoto" && isClickable{
                    HapticGenerator.instance.play(sharpnessValue : 0.5, intensityValue : 0.5)
                    isClickable = false
                    endingFoto.run(fadeOut.easeInOut()){
                        self.changeScene()
                    }
                    
                }
            }
            
        }
    }
    
    func changeScene(){
        SpriteManager.instance.callChapterSelect(index: 2, transition: .fade(with : .white, duration : 2))
    }
    
    func playSound(){
        BGMPlayer.instance.playSound(for: part.mainMenu, index: 1, volume: 0)
        BGMPlayer.instance.player?.setVolume(1, fadeDuration: 1)
    }
}
