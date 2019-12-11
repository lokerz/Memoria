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
    let background = SKSpriteNode()
    
    let text = ["It was the start of a new life for me. At first I was afraid.",
                "They told me they had lost their child due to an accident, and took me in to their family.",
                "They gave me a happy childhood and they loved me just like I was their real child.",
                "Until my father was diagnosed with a heart attack, and had to leave me and mother alone.",
                "It was the toughest time in our life. But we managed to hold out."
    ]
    
    let photo1 = SKSpriteNode(imageNamed: "Photo1")
    let photo2 = SKSpriteNode(imageNamed: "Photo2")
    let photo3 = SKSpriteNode(imageNamed: "Photo3")
    let photo4 = SKSpriteNode(imageNamed: "Photo4")
    
    var monologue = Monologue()
    var nextButton = YellowButton()
    
    
    let house = SKSpriteNode(imageNamed: "House")
    var state = 0
    var stateGesture = 0
    
    var photoWidth = 300
    var photoHeight = 400
    
    var distanceMove : CGFloat = 500
    var durationMove = 0.8
    
    let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.8)
    let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.8)
    
    override func didMove(to view: SKView) {
        monologue = Monologue(for: view)
        addChild(monologue)
        monologue.changeText(to: text[stateGesture])
        monologue.run(fadeIn)
        
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
        
        nextButton = YellowButton(with: CGSize(width: 60, height: 60), text: "➤", textSize: 25)
        nextButton.position = CGPoint(x:view.frame.width-60, y: 60)
        nextButton.zPosition = 4
        nextButton.name = "nextButton"
        nextButton.move(to: .down)
        nextButton.isHidden = true
        addChild(nextButton)

    }
    
    func addGestures(to view: SKView){
        view.removeGestures()        
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedLeft(sender:)))
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoScene.swipedRight(sender:)))
        
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "nextButton" {
                    nextButton.highlight()
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        nextButton.reset()
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "house" && state == 0{
                    addGestures(to: view!)
                    house.run(fadeOut)
                    view!.isUserInteractionEnabled = false
                    
                    photo1.run(fadeIn)
                    photo2.run(fadeIn)
                    
                    monologue.changeText(to: text[stateGesture + 1])
                    
                    self.addChild(self.photo1)
                    self.addChild(self.photo2)
                    self.addChild(self.photo3)
                    self.addChild(self.photo4)
                    self.run(SKAction.wait(forDuration: 1.5)) {
                        self.view!.isUserInteractionEnabled = true
                        self.house.removeFromParent()
                    }
                    state += 1
                }
                else if node.name == "nextButton" {
                    HapticGenerator.instance.play(sharpnessValue : 0.5, intensityValue : 0.5)
                    SpriteManager.instance.callScene(index: 4, transition: .fade(withDuration: 1))
                }
            }
        }
        
    }
    
    @objc func swipedLeft(sender: UISwipeGestureRecognizer){
        view!.isUserInteractionEnabled = false
        let point1 = CGPoint(x: self.photo1.position.x - self.distanceMove, y: view!.frame.height/2)
        let point2 = CGPoint(x: self.photo2.position.x - self.distanceMove, y: view!.frame.height/2)
        let point3 = CGPoint(x: self.photo3.position.x - self.distanceMove, y: view!.frame.height/2)
        let point4 = CGPoint(x: self.photo4.position.x - self.distanceMove, y: view!.frame.height/2)
        
        let move1 = SKAction.move(to: point1, duration: durationMove).easeInOut()
        let move2 = SKAction.move(to: point2, duration: durationMove).easeInOut()
        let move3 = SKAction.move(to: point3, duration: durationMove).easeInOut()
        let move4 = SKAction.move(to: point4, duration: durationMove).easeInOut()
        
        if self.stateGesture < 3{
            photo1.run(move1)
            photo2.run(move2)
            photo3.run(move3)
            photo4.run(move4)
            self.stateGesture += 1
            
            //dont disappear
            monologue.changeText(to: text[stateGesture+1])
            
            //disappear
//            if mono <= stateGesture {
//                monologue.run(fadeIn)
//                mono = stateGesture + 1
//                monologue.changeText(to: text[mono])
//            }
        }
        if self.stateGesture == 3 && self.nextButton.position.y < 0{
            DispatchQueue.main.asyncAfter(deadline: .now() + durationMove) {
                self.nextButton.isHidden = false
                self.nextButton.move(to: .up)
            }
        }
        self.run(SKAction.wait(forDuration: durationMove )) {
            self.view!.isUserInteractionEnabled = true
            
        }
        print(stateGesture)
    }
    
    @objc func swipedRight(sender: UISwipeGestureRecognizer){
        view?.isUserInteractionEnabled = false
        let point1 = CGPoint(x: self.photo1.position.x + self.distanceMove, y: view!.frame.height/2)
        let point2 = CGPoint(x: self.photo2.position.x + self.distanceMove, y: view!.frame.height/2)
        let point3 = CGPoint(x: self.photo3.position.x + self.distanceMove, y: view!.frame.height/2)
        let point4 = CGPoint(x: self.photo4.position.x + self.distanceMove, y: view!.frame.height/2)
        
        let move1 = SKAction.move(to: point1, duration: durationMove).easeInOut()
        let move2 = SKAction.move(to: point2, duration: durationMove).easeInOut()
        let move3 = SKAction.move(to: point3, duration: durationMove).easeInOut()
        let move4 = SKAction.move(to: point4, duration: durationMove).easeInOut()
        
        if self.stateGesture > 0 {
            photo1.run(move1)
            photo2.run(move2)
            photo3.run(move3)
            photo4.run(move4)
            self.stateGesture -= 1
            
            if mono >= stateGesture {
//                monologue.fadeOut()
                monologue.run(fadeIn)
                mono = stateGesture + 1
                monologue.changeText(to: text[mono])
            }
        }
        if self.stateGesture == 2{
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.nextButton.move(to: .down)
            }
        }
        self.run(SKAction.wait(forDuration: durationMove)){
            self.view?.isUserInteractionEnabled = true
        }
    }
    
    override func willMove(from view: SKView) {
        FirstPlayer.instance.player?.stop()
    }
}
