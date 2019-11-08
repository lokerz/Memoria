//
//  GameScene.swift
//  Memoria
//
//  Created by Delvin on 21/10/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class MobilScene: SKScene {
    
    let button = SKSpriteNode(imageNamed: "nextButton.png")
    let ibuAnak = SKSpriteNode(imageNamed: "Ibu Anak")
    let ayah = SKSpriteNode(imageNamed: "Ayah Ibu Anak")
    let paper = SKSpriteNode()
    let paperBig = SKSpriteNode(imageNamed: "Paper")
    let blocker = SKSpriteNode()
    
    var statePaper = 1
    var stateButton = 1
    
    override func didMove(to view: SKView) {
        
        let firstPage = MobilScene(fileNamed: "MobilScene")
        firstPage?.scaleMode = .aspectFill
        
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
        paperBig.zPosition = 3
        paperBig.position = CGPoint(x: view.frame.width/2, y: -view.frame.height/2)
        paperBig.size = CGSize(width: 950, height: 500)
        
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
                    addChild(button)
                    
                    paperBig.run(SKAction.move(to: CGPoint(x: view!.frame.width/2, y: view!.frame.height/2), duration: 1.2))
                    
                    statePaper += 1
                    break
                default:
                    break
                }
            }
            else if node.name == "ibuAnak" {
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
            else if node.name == "nextButton" {
                   let secondPage = PhotoScene(fileNamed: "PhotoScene")
                   secondPage?.scaleMode = .resizeFill
                   self.view?.presentScene(secondPage!, transition: SKTransition.fade(withDuration: 0.5))
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
