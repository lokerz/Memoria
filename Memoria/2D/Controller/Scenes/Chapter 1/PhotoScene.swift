//
//  ThirdPage.swift
//  Memoria
//
//  Created by Delvin on 21/10/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class PhotoScene: SKScene {
    var mono = 0
    let button = SKSpriteNode(imageNamed: "nextButtonBlack")
    let background = SKSpriteNode()
    
    let text = ["This is the start of a new journey in my life",
    "Because of my parents love and affection, I grow up to be a happy and healthy boy.",
    "And I also have a good grade at my school, everything was going well until that accident happen.",
    "My father was diagnosed with a heart attack, and not long after that, he left the world.",
    "It’s the toughest time in my life. Although it takes time, I manage to recover because I know I still need to take care of my mom, a figure whom I need to protect no matter what it takes."
    ]
    
    let photo1 = SKSpriteNode(imageNamed: "Photo1")
    let photo2 = SKSpriteNode(imageNamed: "Photo2")
    let photo3 = SKSpriteNode(imageNamed: "Photo3")
    let photo4 = SKSpriteNode(imageNamed: "Photo4")
    
    let border = SKSpriteNode(imageNamed: "Monologue")
    let monologue = SKLabelNode()
    let monologueName = SKLabelNode()
    
    let house = SKSpriteNode(imageNamed: "House")
    var state = 1
    var stateGesture = 0
    
    var photoWidth = 300
    var photoHeight = 400
    
    var distanceMove : CGFloat = 500
    var durationMove = 0.8
    
    let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.8)
    let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.8)

    override func didMove(to view: SKView) {
        addGestures(to : view)
        
        border.zPosition = 3
        border.anchorPoint = CGPoint(x: 0.5, y: 0)
        border.size = CGSize(width: view.frame.width, height: view.frame.height/4)
        border.position = CGPoint(x: view.frame.width/2, y: 3*view.frame.height/4)
        border.alpha = 0
        
        monologue.horizontalAlignmentMode = .center
        monologue.verticalAlignmentMode = .center
        monologue.preferredMaxLayoutWidth = view.frame.width - 200
        monologue.fontSize = 16
        monologue.numberOfLines = 2
        monologue.position.x = border.position.x
        monologue.position.y = border.position.y + view.frame.height/8
        monologue.zPosition = 4
        monologue.fontColor = .black
        monologue.alpha = 0
        monologue.fontName = "Roboto-Light"
        
        monologueName.text = "Elio"
        monologueName.position = CGPoint(x: 100, y: view.frame.height - 30)
        monologueName.fontSize = 22
        monologueName.fontName = "Roboto-Medium"
        monologueName.fontColor = .black
        monologueName.zPosition = 4
        monologueName.alpha = 0
        
        house.name = "house"
        house.size = CGSize(width: view.frame.width, height: view.frame.height)
        house.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        house.zPosition = -1
        
        addChild(house)
        
        background.size = CGSize(width: view.frame.width, height: view.frame.height)
        background.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        background.color = UIColor.init(red: 140, green: 107, blue: 79, alpha: 0.6)
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
        button.size = CGSize(width: 110, height: 100)
        
        monologueFadeIn()
        monologue.text = text[stateGesture]
    }
    
    func addGestures(to view: SKView){
        for gesture in view.gestureRecognizers!{
            view.removeGestureRecognizer(gesture)
        }
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedLeft(sender:)))
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedRight(sender:)))
            
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
           
            for node in nodesarray {
                if node.name == "house" && state == 1{
                    house.run(fadeOut)
                    view!.isUserInteractionEnabled = false
                    
                    photo1.run(fadeIn)
                    photo2.run(fadeIn)
                    
                    monologue.text = text[stateGesture + 1]
                    
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
                    SpriteManager.instance.callScene(index: 4, transition: .fade(withDuration: 1))
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
            
            if mono <= stateGesture {
                monologueFadeIn()
                mono = stateGesture + 1
                monologue.text = text[mono]
            }
            
            view!.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + durationMove) {
                self.view!.isUserInteractionEnabled = true

            }
        }
        if self.stateGesture == 3{
            DispatchQueue.main.asyncAfter(deadline: .now() + durationMove) {
                self.button.removeFromParent()
                self.addChild(self.button)
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
            
            if mono >= stateGesture {
                monologueFadeOut()
            }
            
                view!.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + durationMove) {
                    self.view!.isUserInteractionEnabled = true
            }
        }
    }

    func monologueFadeIn(){
        border.removeFromParent()
        monologue.removeFromParent()
        monologueName.removeFromParent()
        addChild(border)
        addChild(monologue)
        addChild(monologueName)
        border.run(fadeIn)
        monologue.run(fadeIn)
        monologueName.run(fadeIn)
    }
    
    func monologueFadeOut(){
        border.run(fadeOut)
        monologueName.run(fadeOut)
        monologue.run(fadeOut)
    }
}
