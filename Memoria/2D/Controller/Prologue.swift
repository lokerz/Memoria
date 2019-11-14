//
//  Prologue.swift
//  Memoria
//
//  Created by Delvin on 14/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import SpriteKit

class Prologue: SKScene {
    let prologue = SKLabelNode()
    let background = SKSpriteNode()
    var stateBacot = 1
    let fadeIn = SKAction.fadeIn(withDuration: 1)
    let fadeOut = SKAction.fadeOut(withDuration: 1)
    
    let button = SKSpriteNode(imageNamed: "nextButton")
    
    override func didMove(to view: SKView) {
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.position = CGPoint(x:view.frame.width-60, y: 60)
        button.zPosition = 4
        button.name = "nextButton"
        button.setScale(0.4)
        
        background.name = "background"
        background.color = .black
        background.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        background.size = CGSize(width: view.frame.width, height: view.frame.height)
        
        prologue.fontName = "Helvetica Neue Light"
        prologue.horizontalAlignmentMode = .center
        prologue.verticalAlignmentMode = .center
        prologue.name = "prologue"
        prologue.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        prologue.fontSize = 32
        prologue.numberOfLines = 3
        prologue.preferredMaxLayoutWidth = view.frame.width - 200
        prologue.text = "Have you ever felt confined, lost, had neither direction nor purpose,"
        
        addChild(background)
        addChild(prologue)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
           
            for node in nodesarray {
                stateBacot += 1
                 if node.name == "background" {
                    switch stateBacot {
                    case 2:
                        view!.isUserInteractionEnabled = false
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "fallen into the wheel of life that keeps on spinning, and you are trapped inside,"
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 3:
                        view!.isUserInteractionEnabled = false
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "so you couldn’t help but move along the cycle that even you don't know when and where it will stop,"
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 4:
                        view!.isUserInteractionEnabled = false
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "all you can do is keep moving without having the slightest chance to think and understand about what really happens,"
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 5:
                        view!.isUserInteractionEnabled = false
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "is this really the life you really want to live?"
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 6:
                        view!.isUserInteractionEnabled = false
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "Therefore, this time I want to talk about a journey"
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 7:
                        view!.isUserInteractionEnabled = false
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "yup a journey that will lead me to a destination, a meaning that helps me to know which way this step will tread,"
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 8:
                        view!.isUserInteractionEnabled = false
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "in what place this body will stop, and the answer to life which could satisfy the curiosity of the contents inside this mind."
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 9:
                        view!.isUserInteractionEnabled = false
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "my name is Albert"
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 10:
                        view!.isUserInteractionEnabled = false
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "and this is my story"
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 11:
                        view!.isUserInteractionEnabled = false
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "Today is a special day for me"
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 12:
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "because i was picked up by these people whom will be my new parents"
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 13:
                        view!.isUserInteractionEnabled = false
                        prologue.run(fadeOut)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.prologue.run(self.fadeIn)
                            self.prologue.text = "This is the start of a new journey in my life"
                            self.view!.isUserInteractionEnabled = true
                        }
                    case 14:
                        let firstPage = MobilScene(fileNamed: "MobilScene")
                        firstPage?.scaleMode = .resizeFill
                        self.view?.presentScene(firstPage!, transition: SKTransition.fade(withDuration: 0.5))
                    default:
                        break
                    }
                }

            }
        }
    }
}
