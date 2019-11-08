//
//  ThirdPage.swift
//  Memoria
//
//  Created by Delvin on 21/10/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class PhotoScene: SKScene {
    
    let button = SKSpriteNode(imageNamed: "nextButton")
    let background = SKSpriteNode()
    
    let photo1 = SKSpriteNode(imageNamed: "Photo1")
    let photo2 = SKSpriteNode(imageNamed: "Photo2")
    let photo3 = SKSpriteNode(imageNamed: "Photo3")
    let photo4 = SKSpriteNode(imageNamed: "Photo4")
    
    let house = SKSpriteNode(imageNamed: "House")
    var state = 1
    var stateGesture = 0
    
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
        
        //Declaring Node
        house.name = "house"
        house.size = CGSize(width: view.frame.width-100, height: view.frame.height)
        house.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        
        addChild(house)
        
        background.size = CGSize(width: view.frame.width, height: view.frame.height)
        background.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        background.color = UIColor.init(cgColor: CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1))
        
        photo1.size = CGSize(width: photoWidth, height: photoHeight)
        photo1.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 )
        
        photo2.size = CGSize(width: photoWidth, height: photoHeight)
        photo2.position = CGPoint(x: view.frame.width/2 + 500, y: view.frame.height/2 )
        
        photo3.size = CGSize(width: photoWidth, height: photoHeight)
        photo3.position = CGPoint(x: view.frame.width/2 + 1000, y: view.frame.height/2)
        
        photo4.name = "photo4"
        photo4.size = CGSize(width: photoWidth, height: photoHeight)
        photo4.position = CGPoint(x: view.frame.width/2 + 1500, y: view.frame.height/2)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
           
            for node in nodesarray {
                if node.name == "house" && state == 1{
                    house.run(fadeOut)
                    view!.isUserInteractionEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.view!.isUserInteractionEnabled = true
                        self.house.removeFromParent()
                        self.addChild(self.background)
                        self.addChild(self.photo1)
                        self.addChild(self.photo2)
                        self.addChild(self.photo3)
                        self.addChild(self.photo4)
                    }
                    state += 1
                }
                else if node.name == "nextButton" {
                    let thridPage = WorkScene(fileNamed: "WorkScene")
                    thridPage?.scaleMode = .resizeFill
                    self.view?.presentScene(thridPage!, transition: SKTransition.fade(withDuration: 0.5))
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
            
            let thridPage = PaperWork(fileNamed: "PaperWork")
            thridPage?.scaleMode = .resizeFill
            self.view?.presentScene(thridPage!, transition: SKTransition.fade(withDuration: 0))
        }
    }

}
