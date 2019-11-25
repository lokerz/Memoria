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
    let houseNightAlbert = SKSpriteNode(imageNamed: "House_Night_Albert")
    
    override func didMove(to view: SKView) {
        addGestures(to: view)
        
        houseNightAlbert.size = CGSize(width: view.frame.width, height: view.frame.height)
        houseNightAlbert.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        houseNightAlbert.name = "background"
        houseNightAlbert.zPosition = 0
        houseNightAlbert.alpha = 0
        
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
        
        addChild(houseNight)
        
        view.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.addChild(self.houseNightAlbert)
            self.houseNightAlbert.run(SKAction.fadeIn(withDuration: 1))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.houseNight.removeFromParent()
            self.view?.isUserInteractionEnabled = true
        }
    }
    
    func addGestures(to view: SKView){
        for gesture in view.gestureRecognizers!{
            view.removeGestureRecognizer(gesture)
        }
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
                }
            }
            
        }
    }
    
    @objc func swipedDirection(sender: UISwipeGestureRecognizer){
        view?.isUserInteractionEnabled = false
        let rotate = SKAction.rotate(byAngle: 3.14/6, duration: 0.6)
        knob.run(rotate)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.isUserInteractionEnabled = true
            SpriteManager.instance.callScene(index: 7, transition: .fade(withDuration: 1))
        }
    }
}
