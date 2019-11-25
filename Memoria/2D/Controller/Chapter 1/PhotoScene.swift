//
//  ThirdPage.swift
//  Memoria
//
//  Created by Delvin on 21/10/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class PhotoScene: SKScene {
    let backBlack = SKShapeNode(circleOfRadius: 30)
    
    let button = SKSpriteNode(imageNamed: "nextButton")
    let background = SKSpriteNode()
    
    let photo1 = SKSpriteNode(imageNamed: "Photo1")
    let photo2 = SKSpriteNode(imageNamed: "Photo2")
    let photo3 = SKSpriteNode(imageNamed: "Photo3")
    let photo4 = SKSpriteNode(imageNamed: "Photo4")
    
    let house = SKSpriteNode(imageNamed: "House")
    var state = 1
    var stateGesture = 0
    
    let border = SKSpriteNode()
    
    //Photo Size
    var photoWidth = 300
    var photoHeight = 400
    
    //Photo Scrolling
    var distanceMove : CGFloat = 500
    var durationMove = 0.8
    
    let fadeIn = SKAction.fadeIn(withDuration: 1.2)
    let fadeOut = SKAction.fadeOut(withDuration: 1.2)

    override func didMove(to view: SKView) {
        //Gesture
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedDirection(sender:)))
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedDirection(sender:)))
        
        swipeDown.direction = .down
        swipeUp.direction = .up
        
        view.addGestureRecognizer(swipeDown)
        view.addGestureRecognizer(swipeUp)
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedLeft(sender:)))
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedRight(sender:)))
            
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        
        border.zPosition = 3
        border.anchorPoint = CGPoint(x: 0.5, y: 0)
        border.size = CGSize(width: view.frame.width, height: view.frame.height/4)
        border.position = CGPoint(x: view.frame.width/2, y: 3*view.frame.height/4)
        border.alpha = 0
        
        //Declaring Node
        house.name = "house"
        house.size = CGSize(width: view.frame.width, height: view.frame.height)
        house.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        house.zPosition = -1
        
        addChild(house)
        
        background.size = CGSize(width: view.frame.width, height: view.frame.height)
        background.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        background.color = UIColor.init(red: 140, green: 107, blue: 79, alpha: 0.6)
//        background.color = UIColor.init(hue: 40, saturation: 20, brightness: 1, alpha: 1)
        background.zPosition = 2

        
        photo1.size = CGSize(width: 770, height: 360)
        photo1.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 )
        photo1.alpha = 0
        photo1.zPosition = 1
        
        photo2.size = CGSize(width: 770, height: 360)
        photo2.position = CGPoint(x: view.frame.width/2 + 500, y: view.frame.height/2 )
        photo2.alpha = 0
        photo2.zPosition = 1
        
        photo3.size = CGSize(width: 770, height: 360)
        photo3.position = CGPoint(x: view.frame.width/2 + 1000, y: view.frame.height/2)
        photo3.zPosition = 1
        
        photo4.size = CGSize(width: 770, height: 360)
        photo4.position = CGPoint(x: view.frame.width/2 + 1500, y: view.frame.height/2)
        photo4.zPosition = 1
        
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.position = CGPoint(x:view.frame.width-60, y: 60)
        button.zPosition = 5
        button.name = "nextButton"
        button.setScale(0.4)
        
        backBlack.fillColor = .black
        backBlack.position = button.position
        backBlack.zPosition = 4

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
           
            for node in nodesarray {
                if node.name == "house" && state == 1{
                    house.run(fadeOut)
                    view!.isUserInteractionEnabled = false
                    
                    photo1.run(fadeIn)
                    photo2.run(fadeIn)
                    
//                    self.addChild(self.background)
                    self.addChild(self.photo1)
                    self.addChild(self.photo2)
                    self.addChild(self.photo3)
                    self.addChild(self.photo4)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.view!.isUserInteractionEnabled = true
                        self.house.removeFromParent()
                    }
                    state += 1
                }
                else if node.name == "nextButton" {
                    let scene = SpriteManager.instance.callScene(index: 4)
                    self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                }
            }
        }

    }
    
    @objc func swipedLeft(sender: UISwipeGestureRecognizer){
        let point1 = CGPoint(x: self.photo1.position.x - self.distanceMove, y: view!.frame.height/2)
        let point2 = CGPoint(x: self.photo2.position.x - self.distanceMove, y: view!.frame.height/2)
        let point3 = CGPoint(x: self.photo3.position.x - self.distanceMove, y: view!.frame.height/2)
        let point4 = CGPoint(x: self.photo4.position.x - self.distanceMove, y: view!.frame.height/2)
            
        let move1 = SKAction.move(to: point1, duration: durationMove)
        let move2 = SKAction.move(to: point2, duration: durationMove)
        let move3 = SKAction.move(to: point3, duration: durationMove)
        let move4 = SKAction.move(to: point4, duration: durationMove)
        if self.stateGesture < 3{
            photo1.run(move1)
            photo2.run(move2)
            photo3.run(move3)
            photo4.run(move4)
            self.stateGesture += 1
            view!.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + durationMove) {
                self.view!.isUserInteractionEnabled = true

            }
        }
        if self.stateGesture == 3{
            DispatchQueue.main.asyncAfter(deadline: .now() + durationMove) {
                self.button.removeFromParent()
                self.backBlack.removeFromParent()
                self.addChild(self.button)
                self.addChild(self.backBlack)
            }
                
        }
    }
    
    @objc func swipedRight(sender: UISwipeGestureRecognizer){
    let point1 = CGPoint(x: self.photo1.position.x + self.distanceMove, y: view!.frame.height/2)
    let point2 = CGPoint(x: self.photo2.position.x + self.distanceMove, y: view!.frame.height/2)
    let point3 = CGPoint(x: self.photo3.position.x + self.distanceMove, y: view!.frame.height/2)
    let point4 = CGPoint(x: self.photo4.position.x + self.distanceMove, y: view!.frame.height/2)
        
    let move1 = SKAction.move(to: point1, duration: durationMove)
    let move2 = SKAction.move(to: point2, duration: durationMove)
    let move3 = SKAction.move(to: point3, duration: durationMove)
    let move4 = SKAction.move(to: point4, duration: durationMove)

        if self.stateGesture > 0 {
                photo1.run(move1)
                photo2.run(move2)
                photo3.run(move3)
                photo4.run(move4)
                self.stateGesture -= 1
                view!.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + durationMove) {
                    self.view!.isUserInteractionEnabled = true
            }
        }
    }
    
    @objc func swipedDirection(sender: UISwipeGestureRecognizer){
        if stateGesture == 3{
            background.removeFromParent()
            photo1.removeFromParent()
            photo2.removeFromParent()
            photo3.removeFromParent()
            photo4.removeFromParent()
            
            let scene = SpriteManager.instance.callScene(index: 4)
            self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
        }
    }

    override func willMove(from view: SKView) {
        for gesture in view.gestureRecognizers!{
            view.removeGestureRecognizer(gesture)
        }
    }
}