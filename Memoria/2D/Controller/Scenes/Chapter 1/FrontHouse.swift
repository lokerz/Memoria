//
//  FrontHouse.swift
//  Memoria
//
//  Created by Delvin on 04/11/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class FrontHouse: SKScene{

    var state = 0
    
    let door = SKSpriteNode(imageNamed: "DoorKnob")
    let knob = SKSpriteNode(imageNamed: "DoorHandle")
    
    let fadeIn = SKAction.fadeAlpha(to: 1, duration: 1)
    
    let houseNight = SKSpriteNode(imageNamed: "House_Night")
    let houseNightElio = SKSpriteNode(imageNamed: "House_Night_Albert")
    
    var hintTap = HintGesture(with: 15)
    var hintSwipe = HintGesture(with: 15)
    
    override func didMove(to view: SKView) {
        addGestures(to: view)
        
        houseNightElio.size = CGSize(width: view.frame.width, height: view.frame.height)
        houseNightElio.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        houseNightElio.name = "background"
        houseNightElio.zPosition = 0
        houseNightElio.alpha = 0
        
        houseNight.size = CGSize(width: view.frame.width, height: view.frame.height)
        houseNight.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        houseNight.name = "background"
        houseNight.zPosition = -1
        
        door.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        door.setScale(0.2)
        door.name = "door"
        door.alpha = 0
        door.zPosition = 1
        
        knob.anchorPoint = CGPoint(x: 0.9, y: 0.7)
        knob.position = CGPoint(x: 510, y: 270)
        knob.setScale(0.2)
        knob.alpha = 0
        knob.zPosition = 2
        knob.name = "knob"
        
        hintTap.position = door.position
        hintTap.zPosition = 3
        hintTap.alpha = 0
        hintTap.tap()
        
        hintSwipe.position = door.position
        hintSwipe.zPosition = 3
        hintSwipe.alpha = 0
        hintSwipe.swipe(to: .down)
        
        addChild(houseNight)
        self.run(SKAction.wait(forDuration: 1)){
            self.playAmbience()
        }
        
        view.isUserInteractionEnabled = false
        
        self.run(SKAction.wait(forDuration: 1)){
            self.addChild(self.houseNightElio)
            self.houseNightElio.run(SKAction.fadeAlpha(to: 1, duration: 1)){
            self.houseNight.removeFromParent()
            self.view?.isUserInteractionEnabled = true
            }
        }
        
        self.run(SKAction.wait(forDuration: 6)){
            self.addChild(self.hintTap)
        }
    }
    
    func addGestures(to view: SKView){
        view.removeGestures()
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FrontHouse.swipedDirection(sender:)))
        
        swipeDown.direction = .down
        
        view.addGestureRecognizer(swipeDown)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
            for node in nodesarray {
                if node.name == "background" && state == 0{
                    addChild(door)
                    addChild(knob)
                    
                    door.run(fadeIn)
                    knob.run(fadeIn)
                    state = 1
                    hintTap.removeAllActions()
                    hintTap.run(SKAction.fadeAlpha(to: 0, duration: 1))
                    
                    self.run(SKAction.wait(forDuration: 5)){
                        self.addChild(self.hintSwipe)
                    }
                }
            }
            
        }
    }
    
    @objc func swipedDirection(sender: UISwipeGestureRecognizer){
        view?.isUserInteractionEnabled = false
        let rotate = SKAction.rotate(byAngle: 3.14/6, duration: 0.6)
        knob.run(rotate)
        playDoorSound()
        
        self.run(SKAction.wait(forDuration: 0.4)) {
            self.view?.isUserInteractionEnabled = true
            SpriteManager.instance.callScene(index: 7, transition: .fade(withDuration: 1))
        }
    }
    
    func playDoorSound(){
        FirstPlayer.instance.playSound(for: part.chapter1, index: 3)
    }
    
    func playAmbience(){
        BGMPlayer.instance.player?.stop()
        BGMPlayer.instance.playSound(for: .chapter1, index: 9, volume: 0)
        BGMPlayer.instance.player?.setVolume(0.4, fadeDuration: 2)
        BGMPlayer.instance.player?.numberOfLoops = -1
    }
}
