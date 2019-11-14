//
//  InHouse.swift
//  Memoria
//
//  Created by Delvin on 04/11/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class InHouse : SKScene{
    private var currentNode: SKNode?
    var startTouch = CGPoint()
    
    let pulang1 = SKSpriteNode(imageNamed: "Pulang_1")
    let pulang2 = SKSpriteNode(imageNamed: "Pulang_2")
    let pulang3 = SKSpriteNode(imageNamed: "Pulang_3")
    let pulang4 = SKSpriteNode(imageNamed: "Pulang_4")
    
    let frameDepan = SKSpriteNode(imageNamed: "Frame_Front")
    let frameFoto = SKSpriteNode(imageNamed: "Frame_Photo")
    let frameBelakang = SKSpriteNode(imageNamed: "Frame_Back")
    
    let lastFoto = SKSpriteNode(imageNamed: "Photo_Last")
    
    var state = 0
    var stateGeser = 0
    
    override func didMove(to view: SKView) {
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(InHouse.swipedDirection(sender:)))
        
        swipeUp.direction = .up
        
        view.addGestureRecognizer(swipeUp)
        
        pulang1.name = "Pulang_1"
        pulang1.size = CGSize(width: view.frame.width/2, height: view.frame.height)
        pulang1.position = CGPoint(x: view.frame.width/4, y: -view.frame.height/2)
        pulang1.zPosition = 1
        
        pulang2.name = "Pulang_2"
        pulang2.size = CGSize(width: view.frame.width/2, height: view.frame.height)
        pulang2.position = CGPoint(x: 3*view.frame.width/4, y: -view.frame.height/2)
        pulang2.zPosition = 1
        
        pulang3.name = "Pulang_3"
        pulang3.size = CGSize(width: view.frame.width/2, height: view.frame.height)
        pulang3.position = CGPoint(x: view.frame.width/4, y: -view.frame.height/2)
        pulang3.zPosition = 1
        
        pulang4.name = "Pulang_4"
        pulang4.size = CGSize(width: view.frame.width/2, height: view.frame.height)
        pulang4.position = CGPoint(x: 3*view.frame.width/4, y: -view.frame.height/2)
        pulang4.zPosition = 1
        
        frameDepan.name = "Depan"
        frameDepan.size = CGSize(width: view.frame.width/2, height: view.frame.height)
        frameDepan.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        frameDepan.zPosition = 0
        
        frameFoto.name = "Foto"
        frameFoto.size = CGSize(width: view.frame.width/2, height: view.frame.height)
        frameFoto.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        frameFoto.zPosition = 1
        
        frameBelakang.name = "Belakang"
        frameBelakang.size = CGSize(width: view.frame.width/2, height: view.frame.height)
        frameBelakang.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        frameBelakang.zPosition = 2
        
        lastFoto.size = CGSize(width: view.frame.width/2, height: view.frame.height)
        lastFoto.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        
        addChild(pulang1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.pulang1.run(SKAction.moveTo(y: view.frame.height/2, duration: 1.2))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
           
            for node in nodesarray {
                 if node.name == "Foto" {
                    
                    for gesture in view!.gestureRecognizers!{
                        view!.removeGestureRecognizer(gesture)
                    }
                    self.currentNode = node
                    startTouch = location
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            let newLoc: CGFloat!
            
            if touchLocation.x > startTouch.x{
                newLoc = touchLocation.x - startTouch.x
            }
            else{
                newLoc = -(startTouch.x - touchLocation.x)
            }
            startTouch = touchLocation
            
            print(node.position.x)
            if node.position.x <= 200{
                node.position.x = node.position.x
            }
            else if node.position.x >= view!.frame.width-100{
                node.position.x = node.position.x
            }
            else {
                node.position.x = node.position.x + newLoc
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let node = self.currentNode {
            if node.position.x <= 200 && stateGeser == 0{
               stateGeser += 1
               addChild(lastFoto)
               frameDepan.removeFromParent()
               frameBelakang.removeFromParent()
               frameFoto.removeFromParent()
           }
        }
    }
    
    @objc func swipedDirection(sender: UISwipeGestureRecognizer){
        let goUp = SKAction.moveTo(y: view!.frame.height/2, duration: 1.2)
        let goUp2 = SKAction.moveTo(y: 3*view!.frame.height/2, duration: 1.2)
        
        switch state {
        case 0:
            addChild(pulang2)
            pulang2.run(goUp)
            state += 1
        case 1:
            pulang1.run(goUp2)
            addChild(pulang3)
            pulang3.run(goUp)
            state += 1
        case 2:
            pulang2.run(goUp2)
            addChild(pulang4)
            pulang4.run(goUp)
            state += 1
        case 3:
            pulang1.removeFromParent()
            pulang2.removeFromParent()
            pulang3.removeFromParent()
            pulang4.removeFromParent()
            addChild(frameDepan)
            addChild(frameBelakang)
            
            frameDepan.isUserInteractionEnabled = false
            frameBelakang.isUserInteractionEnabled = false
            addChild(frameFoto)
            state += 1
        default:
            break
        }
    }
    
    override func willMove(from view: SKView) {
        for gesture in view.gestureRecognizers!{
            view.removeGestureRecognizer(gesture)
        }
    }
}
