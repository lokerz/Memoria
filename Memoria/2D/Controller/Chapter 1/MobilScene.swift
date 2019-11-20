//
//  GameScene.swift
//  Memoria
//
//  Created by Delvin on 21/10/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class MobilScene: SKScene {
    var stateMonologue = 0
    var stateMono = 0
    
    let button = SKSpriteNode(imageNamed: "nextButton.png")
    let ibuAnak = SKSpriteNode(imageNamed: "Ibu Anak")
    let ayah = SKSpriteNode(imageNamed: "Ayah Ibu Anak")
    let paper = SKSpriteNode()
    let paperBig = SKSpriteNode(imageNamed: "Paper")
    let blocker = SKSpriteNode()
    
    let monologue = SKLabelNode()
    
    let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.5)
    let fadeOut = SKAction.fadeAlpha(by: -1, duration: 0.5)
    
    var statePaper = 1
    var stateButton = 1
    
    let border = SKSpriteNode()
    
    override func didMove(to view: SKView) {
//        let linearGradientSize = size
//        let linearGradientColors = [UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1),
//                                    UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.5),
//                                    UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0)]
//        let linearGradientLocations: [CGFloat] = [0, 0.5, 1]
//        let textureCount = 8
//        let textures = (0..<textureCount).map { (index) -> SKTexture in
//            let angle : CGFloat = 33/7
//          return SKTexture(linearGradientWithAngle: angle, colors: linearGradientColors, locations: linearGradientLocations, size: linearGradientSize)
//        }
//        let border = SKSpriteNode(texture: textures.first)
        
        border.texture = SKTexture(imageNamed: "Monologue")
        
        border.zPosition = 3
        border.anchorPoint = CGPoint(x: 0.5, y: 0)
        border.size = CGSize(width: view.frame.width, height: view.frame.height/4)
        border.position = CGPoint(x: view.frame.width/2, y: 3*view.frame.height/4)
        border.alpha = 0
        
        //Declaring Node
        ibuAnak.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ibuAnak.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 50)
        ibuAnak.zPosition = -1
        ibuAnak.setScale(0.6)
        ibuAnak.name = "ibuAnak"
        
        ayah.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ayah.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        ayah.zPosition = 0
        ayah.setScale(0.5)
        ayah.alpha = 0
        
        paper.name = "paper"
        paper.position = CGPoint(x: 250, y: 30)
        paper.zPosition = 1
        paper.size = CGSize(width: 150, height: 60)
        
        blocker.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        blocker.zPosition = 2
        blocker.size = CGSize(width: view.frame.width, height: view.frame.height)
        blocker.color = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        blocker.alpha = 0.4
        
        paperBig.name = "paperBig"
        paperBig.zPosition = 2
        paperBig.position = CGPoint(x: view.frame.width/2, y: -view.frame.height/2)
        paperBig.size = CGSize(width: 950, height: 500)
        
        monologue.horizontalAlignmentMode = .center
        monologue.verticalAlignmentMode = .center
        monologue.preferredMaxLayoutWidth = view.frame.width - 200
        monologue.fontSize = 22
        monologue.numberOfLines = 2
        monologue.position.x = border.position.x
        monologue.position.y = border.position.y + view.frame.height/8
        monologue.zPosition = 4
        monologue.fontColor = .black
        monologue.alpha = 0
        
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.position = CGPoint(x:view.frame.width-60, y: 60)
        button.zPosition = 4
        button.name = "nextButton"
        button.setScale(0.4)
        
        addChild(ibuAnak)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Registering Touch Actions
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)
            
        for node in nodesarray {
            if node.name == "paper" {
                switch statePaper {
                case 1:
                    addChild(blocker)
                    addChild(paperBig)
                    
                    paperBig.run(SKAction.move(to: CGPoint(x: view!.frame.width/2, y: view!.frame.height/2), duration: 1.2))

                    statePaper += 1
                    break
                default:
                    break
                }
            }
            else if node.name == "ibuAnak" {
                if stateMonologue == 0{
                    stateMonologue += 1
                    addChild(border)
                    addChild(monologue)
                    border.run(fadeIn)
                    monologue.run(fadeIn)
                    
                    monologue.text = "Today is a special day day for me"
                }
                else if stateMonologue == 1{
                    border.run(fadeOut)
                    monologue.run(fadeOut)
                    ayah.removeFromParent()
                    paper.removeFromParent()
                    
                    ibuAnak.run(SKAction.move(to: CGPoint(x: view!.frame.width/2, y: view!.frame.height/2), duration: 1.5))
                    ibuAnak.run(SKAction.scale(to: 0.5, duration: 1.5))
                    
                    addChild(ayah)
                    addChild(paper)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.ayah.run(SKAction.fadeIn(withDuration: 1))
                    }
                }
            }
            else if node.name == "paperBig"{
                if stateMono == 0{
                    border.removeFromParent()
                    monologue.removeFromParent()
                    addChild(border)
                    addChild(monologue)
                    
                    border.run(SKAction.fadeIn(withDuration: 0.5))
                    monologue.run(SKAction.fadeIn(withDuration: 0.5))
                    monologue.text = "because i was picked up by these people whom will be my new parents"
                    
                    button.removeFromParent()
                    stateMono += 1
                }
                else if stateMono == 1{
                    button.removeFromParent()
                    addChild(button)
                }
            }
            else if node.name == "nextButton" {
                   let scene = SpriteManager.instance.callScene(index: 3)
                   self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
            }
            }
        }
    }

}

extension SKSpriteNode {
    func aspectFillToSize(fillSize: CGSize) {
        if texture != nil {
            self.size = texture!.size()

            let verticalRatio = fillSize.height / self.texture!.size().height
            let horizontalRatio = fillSize.width /  self.texture!.size().width

            let scaleRatio = horizontalRatio > verticalRatio ? horizontalRatio : verticalRatio

            self.setScale(scaleRatio)
        }
    }
}
