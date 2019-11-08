//
//  2ndPage.swift
//  Memoria
//
//  Created by Delvin on 21/10/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class WorkScene: SKScene {
    private var currentNode: SKNode?
    let button = SKSpriteNode(imageNamed: "nextButton.png")
    let backgroundImage = SKSpriteNode()
    let border = SKSpriteNode()
    let finish = SKSpriteNode()
    let move = SKSpriteNode(imageNamed: "Orange")
    var a : Int = 1

    
    override func didMove(to view: SKView) {
        
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.position = CGPoint(x:view.frame.width-60, y: 60)
        button.zPosition = 2
        button.name = "nextButton"
        button.setScale(0.4)
        
        backgroundImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundImage.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        backgroundImage.texture = SKTexture(imageNamed: "Godjilla")
        backgroundImage.name = "background"
        backgroundImage.zPosition = -1
        backgroundImage.aspectFillToSize(fillSize: view.frame.size)
        
        self.addChild(backgroundImage)
        
        move.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        move.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        move.name = "moving"
        move.size = CGSize(width: 100, height: 100)
        
        self.addChild(move)
        
        border.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        border.position = CGPoint(x: 200, y: 200)
        border.color = .green
        border.size = CGSize(width: 50, height: 50)
        border.name = "collision"
        
        addChild(border)
        
       finish.anchorPoint = CGPoint(x: 0.5, y: 0.5)
       finish.position = CGPoint(x: -50, y: -50)
       finish.color = .red
       finish.size = CGSize(width: 50, height: 50)
       finish.name = "finish"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
           
            for node in nodesarray {
                if node.name == "nextButton" {
                    let thridPage = PhotoScene(fileNamed: "ThirdPage")
                    thridPage?.scaleMode = .resizeFill
                    self.view?.presentScene(thridPage!, transition: SKTransition.fade(withDuration: 0.5))
                }
                else if node.name == "moving" {
                    self.currentNode = node
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if a == 1 || a == 2 {
            if let touch = touches.first, let node = self.currentNode {
                let touchLocation = touch.location(in: self)
                node.position = touchLocation
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
        checkCollisions()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    func checkCollisions(){
        enumerateChildNodes(withName: "moving") { node, _ in
            let jeruk = node as! SKSpriteNode
            
            if jeruk.frame.intersects(self.border.frame){
                jeruk.position = self.border.position
                self.view?.isUserInteractionEnabled = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.addChild(self.finish)
                    self.view?.isUserInteractionEnabled = true
                    self.finish.position = CGPoint(x: 700, y: 200)
                    self.border.position = CGPoint(x: -50, y: -50)
                    self.a = 2
                }
            }
            else if jeruk.frame.intersects(self.finish.frame){
                jeruk.position = self.finish.position
                self.finish.position = CGPoint(x: -50, y: -50)
                self.addChild(self.button)
                self.a = 3
            }
            else if self.a == 2 {
                jeruk.position = CGPoint(x: 200, y: 200)
            }
            else if self.a == 1{
                jeruk.position = CGPoint(x: self.view!.frame.width/2, y: self.view!.frame.height/2)
            }
        }
    }
}
