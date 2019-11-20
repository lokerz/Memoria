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
    
    let animationDuration = 1.2
    
    let background = SKSpriteNode()
    
    let pulang1 = SKSpriteNode(imageNamed: "Pulang_1")
    let pulang2 = SKSpriteNode(imageNamed: "Pulang_2")
    let pulang3 = SKSpriteNode(imageNamed: "Pulang_3")
    let pulang4 = SKSpriteNode(imageNamed: "Pulang_4")
    let pulang5 = SKSpriteNode(imageNamed: "Pulang_5")
    
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
        pulang1.size = CGSize(width: view.frame.width, height: view.frame.height)
        pulang1.position = CGPoint(x: view.frame.width/2, y: -view.frame.height/2)
        pulang1.zPosition = 1
        
        background.color = .white
        background.size = pulang1.size
        background.zPosition = -1
        background.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        
        pulang2.name = "Pulang_2"
        pulang2.size = pulang1.size
        pulang2.position = pulang1.position
        pulang2.zPosition = 1
        
        pulang3.name = "Pulang_3"
        pulang3.size = pulang1.size
        pulang3.position = pulang1.position
        pulang3.zPosition = 1
        
        pulang4.name = "Pulang_4"
        pulang4.size = pulang1.size
        pulang4.position = pulang1.position
        pulang4.zPosition = 1
        
        pulang5.name = "Pulang_5"
        pulang5.size = pulang1.size
        pulang5.position = pulang1.position
        pulang5.zPosition = 1
        
        frameDepan.name = "Depan"
        frameDepan.size = CGSize(width: view.frame.width, height: view.frame.height)
        frameDepan.position = pulang1.position
        frameDepan.zPosition = 0
        
        frameFoto.name = "Foto"
        frameFoto.size = CGSize(width: view.frame.width, height: view.frame.height)
        frameFoto.position = pulang1.position
        frameFoto.zPosition = 1
        
        frameBelakang.name = "Belakang"
        frameBelakang.size = CGSize(width: view.frame.width, height: view.frame.height)
        frameBelakang.position = pulang1.position
        frameBelakang.zPosition = 2
        
        lastFoto.size = CGSize(width: view.frame.width, height: view.frame.height)
        lastFoto.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        
        addChild(pulang1)
        addChild(background)
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
            var newLocy: CGFloat = 0.0
            var newLocx: CGFloat = 0.0
            
            //up
            if touchLocation.y > startTouch.y{
                newLocy = touchLocation.y - startTouch.y
            }
                //down
            else{
                if node.position.y > 200{
                    newLocy = -(startTouch.y - touchLocation.y)
                }
            }
            
            //right
            if touchLocation.x > startTouch.x{
                if node.position.x < 460{
                    newLocx = touchLocation.x - startTouch.x
                }
            }
                //left
            else{
                if node.position.x > 430{
                    newLocx = -(startTouch.x - touchLocation.x)
                }
            }
            
            startTouch = touchLocation
            
            print(node.position.y)
            if node.position.y < 280{
                node.position.y = node.position.y + newLocy
                node.position.x = node.position.x + newLocx
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let node = self.currentNode {
            if node.position.y > 280 && stateGeser == 0{
               stateGeser += 1
               addChild(lastFoto)
               frameDepan.removeFromParent()
               frameBelakang.removeFromParent()
               frameFoto.removeFromParent()
           }
        }
    }
    
    @objc func swipedDirection(sender: UISwipeGestureRecognizer){
        let goUp = SKAction.moveTo(y: view!.frame.height/2, duration: animationDuration)
        let goUp2 = SKAction.moveTo(y: 3*view!.frame.height/2, duration: animationDuration)
        
        switch state {
        case 0:
            wait()
            addChild(pulang2)
            pulang2.run(goUp)
            pulang1.run(goUp2)
            state += 1
        case 1:
            wait()
            addChild(pulang3)
            pulang2.run(goUp2)
            pulang3.run(goUp)
            state += 1
        case 2:
            wait()
            pulang3.run(goUp2)
            addChild(pulang4)
            pulang4.run(goUp)
            state += 1
        case 3:
            wait()
            pulang4.run(goUp2)
            addChild(pulang5)
            pulang5.run(goUp)
            state += 1
        case 4:
            wait()
            pulang1.removeFromParent()
            pulang2.removeFromParent()
            pulang3.removeFromParent()
            pulang4.removeFromParent()
            pulang5.run(goUp2)
            addChild(frameDepan)
            addChild(frameBelakang)
            
            frameDepan.isUserInteractionEnabled = false
            frameBelakang.isUserInteractionEnabled = false
            addChild(frameFoto)
            
            frameDepan.run(goUp)
            frameBelakang.run(goUp)
            frameFoto.run(goUp)
            state += 1
        default:
            break
        }
    }
    
    func wait(){
        view!.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            self.view!.isUserInteractionEnabled = true
        }
    }
    
    override func willMove(from view: SKView) {
        for gesture in view.gestureRecognizers!{
            view.removeGestureRecognizer(gesture)
        }
    }
}
