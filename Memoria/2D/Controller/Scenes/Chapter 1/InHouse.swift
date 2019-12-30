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
    
    let animationDuration = 0.75
    
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
    var isReadyToChange = false
    
    var spriteManager = SpriteManager.instance
    
    var hintSwipe = HintGesture(with: 15)
    var hintSwipe2 = HintGesture(with: 15)
    var hintTap = HintGesture(with: 15)
    
    override func didMove(to view: SKView) {
        view.isUserInteractionEnabled = false
        
        pulang1.name = "Pulang_1"
        pulang1.size = CGSize(width: view.frame.width, height: view.frame.height)
        pulang1.position = CGPoint(x: view.frame.width/2, y: -view.frame.height/3)
        pulang1.zPosition = 1
        
        pulang2.name = "Pulang_2"
        pulang2.size = pulang1.size
        pulang2.position = CGPoint(x: view.frame.width/2, y: -7*view.frame.height/6)
        pulang2.zPosition = 1
        
        pulang3.name = "Pulang_3"
        pulang3.size = pulang1.size
        pulang3.position = pulang2.position
        pulang3.zPosition = 1
        
        pulang4.name = "Pulang_4"
        pulang4.size = pulang1.size
        pulang4.position = pulang2.position
        pulang4.zPosition = 1
        
        pulang5.name = "Pulang_5"
        pulang5.size = pulang1.size
        pulang5.position = pulang2.position
        pulang5.zPosition = 1
        
        frameDepan.name = "Depan"
        frameDepan.size = CGSize(width: view.frame.width, height: view.frame.height)
        frameDepan.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        frameDepan.alpha = 0
        frameDepan.zPosition = 0
        
        frameFoto.name = "Foto"
        frameFoto.size = CGSize(width: view.frame.width, height: view.frame.height)
        frameFoto.position = frameDepan.position
        frameFoto.alpha = frameDepan.alpha
        frameFoto.zPosition = 1
        
        frameBelakang.name = "Belakang"
        frameBelakang.size = CGSize(width: view.frame.width, height: view.frame.height)
        frameBelakang.position = frameDepan.position
        frameBelakang.alpha = frameDepan.alpha
        frameBelakang.zPosition = 2
        
        lastFoto.name = "lastFoto"
        lastFoto.size = CGSize(width: view.frame.width, height: view.frame.height)
        lastFoto.position = CGPoint(x: view.frame.width/2, y: -view.frame.height/2)
        lastFoto.zPosition = 3
        
        addChild(pulang1)
        addChild(pulang2)
        
        let moveUp = [SKAction.wait(forDuration: 0.2).easeInOut(), SKAction.moveTo(y: view.frame.height/2, duration: self.animationDuration).easeInOut()]
        let moveUp2 = [SKAction.wait(forDuration: 0.2).easeInOut(), SKAction.moveTo(y: -view.frame.height/3, duration: self.animationDuration).easeInOut()]
        
        pulang1.run(SKAction.sequence(moveUp))
        pulang2.run(SKAction.sequence(moveUp2)){
            view.isUserInteractionEnabled = true
        }
        
        addGesture(to : view)
        
        hintSwipe.position = CGPoint(x: frame.midX + 250, y: frame.midY)
        hintSwipe.zPosition = 4
        hintSwipe.alpha = 0
        hintSwipe.swipe(to: .up)
        
        hintSwipe2.position = lastFoto.position
        hintSwipe2.zPosition = 4
        hintSwipe2.alpha = 0
        hintSwipe2.swipe(to: .up)
        
        hintTap.position = CGPoint(x: frame.midX + 150, y: frame.midY)
        hintTap.zPosition = 4
        hintTap.alpha = 0
        hintTap.tap()
        
        self.run(SKAction.wait(forDuration: 5)){
            self.addChild(self.hintSwipe)
        }
    }
    
    func addGesture(to view : SKView){
        view.removeGestures()
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipedDirectionUp(sender:)))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipedDirectionDown(sender:)))
        
        swipeUp.direction = .up
        swipeDown.direction = .down
        
        view.addGestureRecognizer(swipeDown)
        view.addGestureRecognizer(swipeUp)
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
            
            if node.position.y <= 280{
                node.position.y = node.position.y + newLocy/2.8
                node.position.x = node.position.x + newLocx/2.8
            }
            else{
                node.position.y = 280
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let node = self.currentNode {
            if node.position.y >= 280 && stateGeser == 0{
                playPhotoDragSound()
                stateGeser += 1
                addChild(lastFoto)
                frameFoto.run(SKAction.fadeAlpha(to: 0, duration: animationDuration/2).easeInOut())
                let move = SKAction.moveTo(y: view!.frame.height/2, duration: animationDuration)
                lastFoto.run(move.easeInOut()) {
                    self.isReadyToChange = true
                }
                
                self.run(SKAction.wait(forDuration: 6)){
                    self.addChild(self.hintTap)
                }
            }
        }
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)

            for node in nodesarray {
                if node.name == "lastFoto" {
                    let scale = SKAction.scale(by: 10, duration: 4).easeIn()
                    node.run(scale)
                    self.run(SKAction.wait(forDuration: 1)){
                        SpriteManager.instance.loadGame(level: 1)
                    }
                }
            }
        }
    }
    
    @objc func swipedDirectionUp(sender: UISwipeGestureRecognizer){
        hintSwipe.removeAllActions()
        hintSwipe.run(SKAction.fadeAlpha(to: 0, duration: 1))
        
        let moveHigher = SKAction.moveTo(y: 13 * view!.frame.height/6, duration: animationDuration).easeInOut()
        let moveMain = SKAction.moveTo(y: view!.frame.height/2, duration: animationDuration).easeInOut()
        let moveHigh = SKAction.moveTo(y: 4*view!.frame.height/3, duration: animationDuration).easeInOut()
        let moveLow = SKAction.moveTo(y: -view!.frame.height/3, duration: animationDuration).easeInOut()
        
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: animationDuration).easeInOut()
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: animationDuration).easeInOut()
        
        switch state {
        case 0:
            wait()
            removePulang()
            addChild(pulang1)
            addChild(pulang2)
            addChild(pulang3)
            pulang2.run(moveMain)
            pulang1.run(moveHigh)
            pulang3.run(moveLow)
            state += 1
        case 1:
            wait()
            removePulang()
            addChild(pulang1)
            addChild(pulang2)
            addChild(pulang3)
            addChild(pulang4)
            pulang1.run(moveHigher)
            pulang2.run(moveHigh)
            pulang3.run(moveMain)
            pulang4.run(moveLow)
            state += 1
        case 2:
            wait()
            removePulang()
            addChild(pulang3)
            addChild(pulang4)
            addChild(pulang5)
            addChild(pulang2)
            pulang2.run(moveHigher)
            pulang3.run(moveHigh)
            pulang4.run(moveMain)
            pulang5.run(moveLow)
            state += 1
        case 3:
            wait()
            removePulang()
            addChild(pulang3)
            addChild(pulang4)
            addChild(pulang5)
            pulang3.run(moveHigher)
            pulang4.run(moveHigh)
            pulang5.run(moveMain)
            state += 1
        case 4:
            wait()
            removePulang()
            
            self.run(SKAction.wait(forDuration: animationDuration/2)){
                self.playPhotoDropSound()
            }
            addChild(pulang4)
            addChild(pulang5)
            pulang4.run(moveHigher)
            pulang5.run(moveHigh)
            pulang5.run(fadeOut)
            addChild(frameDepan)
            addChild(frameBelakang)
            addChild(frameFoto)
            
            frameDepan.isUserInteractionEnabled = false
            frameBelakang.isUserInteractionEnabled = false
            
            self.frameDepan.run(SKAction.sequence([SKAction.wait(forDuration: animationDuration) ,fadeIn]))
            self.frameBelakang.run(SKAction.sequence([SKAction.wait(forDuration: animationDuration),fadeIn]))
            self.frameFoto.run(SKAction.sequence([SKAction.wait(forDuration: 4*animationDuration/3),fadeIn])){
                self.run(SKAction.wait(forDuration: 5)){
                    self.addChild(self.hintSwipe2)
                }
            }
            state += 1
        default:
            break
        }
    }
    
    @objc func swipedDirectionDown(sender: UISwipeGestureRecognizer){
        let moveMain = SKAction.moveTo(y: view!.frame.height/2, duration: animationDuration).easeInOut()
        let moveHigh = SKAction.moveTo(y: 4*view!.frame.height/3, duration: animationDuration).easeInOut()
        let moveLow = SKAction.moveTo(y: -view!.frame.height/3, duration: animationDuration).easeInOut()
        let moveOut = SKAction.moveTo(y: -7*view!.frame.height/6, duration: animationDuration).easeInOut()
        
        switch state {
        case 1:
            wait()
            removePulang()
            addChild(pulang1)
            addChild(pulang2)
            addChild(pulang3)
            pulang1.run(moveMain)
            pulang2.run(moveLow)
            pulang3.run(moveOut)
            state -= 1
        case 2:
            wait()
            removePulang()
            addChild(pulang1)
            addChild(pulang2)
            addChild(pulang3)
            addChild(pulang4)
            pulang1.run(moveHigh)
            pulang2.run(moveMain)
            pulang3.run(moveLow)
            pulang4.run(moveOut)
            state -= 1
        case 3:
            wait()
            removePulang()
            addChild(pulang2)
            addChild(pulang3)
            addChild(pulang4)
            addChild(pulang5)
            pulang2.run(moveHigh)
            pulang3.run(moveMain)
            pulang4.run(moveLow)
            pulang5.run(moveOut)
            state -= 1
        case 4:
            wait()
            removePulang()
            addChild(pulang3)
            addChild(pulang4)
            addChild(pulang5)
            pulang3.run(moveHigh)
            pulang4.run(moveMain)
            pulang5.run(moveLow)
            state -= 1
        default:
            break
        }
    }
    
    func removePulang(){
        pulang1.removeFromParent()
        pulang2.removeFromParent()
        pulang3.removeFromParent()
        pulang4.removeFromParent()
        pulang5.removeFromParent()
    }
    
    func wait(){
        view!.isUserInteractionEnabled = false
        self.run(SKAction.wait(forDuration: animationDuration)) {
            self.view!.isUserInteractionEnabled = true
        }
    }
    
    func playPhotoDropSound(){
        FirstPlayer.instance.playSound(for: part.chapter1, index: 2)
    }
    
    func playPhotoDragSound(){
        FirstPlayer.instance.playSound(for: part.chapter1, index: 4)
    }
}
