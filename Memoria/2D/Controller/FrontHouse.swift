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
    let button = SKSpriteNode(imageNamed: "nextButton")
    
    let houseBG = SKSpriteNode(imageNamed: "House_Night")
    let door = SKSpriteNode(imageNamed: "DoorKnob")
    let knob = SKSpriteNode(imageNamed: "Knob")
    
    override func didMove(to view: SKView) {
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FrontHouse.swipedDirection(sender:)))
        
        swipeDown.direction = .down
        
        view.addGestureRecognizer(swipeDown)
        
        houseBG.size = CGSize(width: view.frame.width - 100, height: view.frame.height)
        houseBG.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        houseBG.name = "background"
        houseBG.zPosition = -1
        
        door.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        door.name = "door"
        door.zPosition = 0
        
        knob.anchorPoint = CGPoint(x: 1, y: 1)
        knob.position = CGPoint(x: 500, y: 300)
        knob.zPosition = 1
        knob.name = "knob"
        
        addChild(houseBG)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
            for node in nodesarray {
                if node.name == "background" && state == 0{
                    addChild(door)
                    addChild(knob)
                    state = 1
                }
            }
            
        }
    }
    
    @objc func swipedDirection(sender: UISwipeGestureRecognizer){
        view?.isUserInteractionEnabled = false
        let rotate = SKAction.rotate(byAngle: 3.14/3, duration: 1)
        knob.run(rotate)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.view?.isUserInteractionEnabled = true
            let sixthPage = InHouse(fileNamed: "InHouse")
            sixthPage?.scaleMode = .resizeFill
            self.view?.presentScene(sixthPage!, transition: SKTransition.fade(withDuration: 0.5))
        }
    }
    
}
