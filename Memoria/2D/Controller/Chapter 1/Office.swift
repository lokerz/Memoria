//
//  Office.swift
//  Memoria
//
//  Created by Delvin on 04/11/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit
import UIKit

class Office: SKScene{
    var state = 1
    var i = 1
    
    let button = SKSpriteNode(imageNamed: "nextButton")
    let border = SKSpriteNode()
    
    let monolog = SKLabelNode()
    let mobA = SKSpriteNode(imageNamed: "mobA")
    
    let message = "Come with me, and see what has been foretold..."
    
    let albertBG = SKSpriteNode(imageNamed: "Kerja_3")
    
    var spriteManager = SpriteManager.instance
    
    var bubbles = [Bubble]()
    var index = 0
    var height : CGFloat = 0
    
    
    override func didMove(to view: SKView) {
        index = 0
        
        border.zPosition = 1
        border.anchorPoint = CGPoint(x: 0.5, y: 0)
        border.size = CGSize(width: view.frame.width, height: view.frame.height/4)
        border.position = CGPoint(x: view.frame.width/2, y: 3*view.frame.height/4)
        
        albertBG.name = "background"
        albertBG.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        albertBG.zPosition = -1
        albertBG.size = CGSize(width: view.frame.width, height: view.frame.height)
        
        monolog.text = ""
        monolog.zPosition = 2
        monolog.fontSize = 16
        monolog.fontColor = .black
        monolog.fontName = "Times New Roman"
        monolog.position = CGPoint(x: view.frame.width/2, y: 6*view.frame.height/7)
        monolog.numberOfLines = 3
        monolog.preferredMaxLayoutWidth = view.frame.width-100
        
        button.position = CGPoint(x:view.frame.width-60, y: 60)
        button.zPosition = 1
        button.name = "nextButton"
        button.setScale(0.4)
        
        mobA.size = CGSize(width: view.frame.width, height: view.frame.height)
        mobA.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        mobA.zPosition = -0.5
        
        addChild(mobA)
        addChild(albertBG)
        addChild(border)

        addBubble()
        moveBubble()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            
            for node in nodesarray {
                if node.name == "nextButton"{
                    let scene = spriteManager.callScene(index: 6)
                    self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                }
                if node.name == "background"{
                    moveBubble()
                    i += 1
                    if i == bubbles.count{
                        addChild(button)
                    }
                }
            }
        }
    }
    
    func setGradientBackground(layer: CALayer) -> SKSpriteNode {
        let view = UIView()
        layer.frame = self.frame
        view.layer.addSublayer(layer)
        
        UIGraphicsBeginImageContext(self.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let bgImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return SKSpriteNode(texture: SKTexture(image: bgImage!))
    }
    
    func addBubble(){
        let widthOffice: CGFloat = 200
        let bubbleAlbertPosition = view!.frame.width/2 - 40
        let bubbleJamesPosition = view!.frame.width/2 + 170
        let tSize : CGFloat = 16
        
        let bubble = Bubble()
        let text = "Hey Albert"
        let position = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble.createBubble(position: position, width: widthOffice, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text, textColor: .white, textSize : tSize)
        bubbles.append(bubble)
        
        let bubble2 = Bubble()
        let text2 = "Yes, James?"
        let position2 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble2.createBubble(position: position2, width: widthOffice, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text2, textColor: .white, textSize : tSize)
        bubbles.append(bubble2)
        
        
        let bubble3 = Bubble()
        let text3 = "Are you busy after work?"
        let position3 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble3.createBubble(position: position3, width: widthOffice, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text3, textColor: .white, textSize : tSize)
        bubbles.append(bubble3)
        
        let bubble4 = Bubble()
        let text4 = "Not really, why?"
        let position4 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble4.createBubble(position: position4, width: widthOffice, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text4, textColor: .white, textSize : tSize)
        bubbles.append(bubble4)
        
        let bubble5 = Bubble()
        let text5 = "So me and the others want to hang out to release some stress after work, do you wanna join us?"
        let position5 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble5.createBubble(position: position5, width: widthOffice, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text5, textColor: .white, textSize : tSize)
        bubbles.append(bubble5)
        
        let bubble6 = Bubble()
        let text6 = ["Sorry James, I think I'll pass","Where do you want to go anyways?"]
        let position6 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble6.createChoiceBubble(position: position6, width: widthOffice, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, choices: text6, textColor: .white, textSize : tSize)
        bubbles.append(bubble6)
        
        let bubble7 = Bubble()
        let text7 = "We want to go to the new restaurant across the office, so how is it? Do you wanna join?"
        let position7 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble7.createBubble(position: position7, width: widthOffice, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text7, textColor: .white, textSize : tSize)
        bubbles.append(bubble7)
        
        let bubble8 = Bubble()
        let text8 = "It sounds interesting but I'm sorry I cannot join you guys"
        let position8 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble8.createBubble(position: position8, width: widthOffice, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text8, textColor: .white, textSize : tSize)
        bubbles.append(bubble8)
        
        let bubble9 = Bubble()
        let text9 = "Why? Do you still have stuff to do?"
        let position9 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble9.createBubble(position: position9, width: widthOffice, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text9, textColor: .white, textSize : tSize)
        bubbles.append(bubble9)
        
        let bubble10 = Bubble()
        let text10 = "Not really, I just don't feel like joining you today."
        let position10 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble10.createBubble(position: position10, width: widthOffice, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text10, textColor: .white, textSize : tSize)
        bubbles.append(bubble10)
        
        let bubble11 = Bubble()
        let text11 = "C'mon Albert, these past few days you have been so quiet, do you have a problem? You can share it with me if you want."
        let position11 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble11.createBubble(position: position11, width: widthOffice, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text11, textColor: .white, textSize : tSize)
        bubbles.append(bubble11)
        
        let bubble12 = Bubble()
        let text12 = ["I just need a bit of time for myself.","Yeah, I have something in my mind, but I think I can solve it by myself."]
        let position12 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble12.createChoiceBubble(position: position12, width: widthOffice, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, choices: text12, textColor: .white, textSize : tSize)
        bubbles.append(bubble12)
        
        let bubble13 = Bubble()
        let text13 = "You should enjoy your life from time to time, I think it would be a pity when you have a very good career but you cannot enjoy it yourself."
        let position13 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble13.createBubble(position: position13, width: widthOffice, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text13, textColor: .white, textSize : 16)
        bubbles.append(bubble13)
        
        let bubble14 = Bubble()
        let text14 = ["Haha yeah I know, I'll try to enjoy it when the time is right.","Haha, I think it's still too soon for me to enjoy my time"]
        let position14 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble14.createChoiceBubble(position: position14, width: widthOffice, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, choices: text14, textColor: .white, textSize: tSize)
        bubbles.append(bubble14)
        
        let bubble15 = Bubble()
        let text15 = "But you know, working too hard is not good for your body and mind"
        let position15 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble15.createBubble(position: position15, width: widthOffice, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text15, textColor: .white, textSize : tSize)
        bubbles.append(bubble15)
        
        let bubble16 = Bubble()
        let text16 = "Relax, I'm already used to this kind of job."
        let position16 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble16.createBubble(position: position16, width: widthOffice, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text16, textColor: .white, textSize : tSize)
        bubbles.append(bubble16)
        
        let bubble17 = Bubble()
        let text17 = "Hahaha okay then, if you change your mind, just call me later okay?"
        let position17 = CGPoint(x: bubbleJamesPosition, y: view!.frame.height/2)
        bubble17.createBubble(position: position17, width: widthOffice, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text17, textColor: .white, textSize : tSize)
        bubbles.append(bubble17)
        
        let bubble18 = Bubble()
        let text18 = "Okay.."
        let position18 = CGPoint(x: bubbleAlbertPosition, y: view!.frame.height/2)
        bubble18.createBubble(position: position18, width: widthOffice, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text18, textColor: .white, textSize : tSize)
        bubbles.append(bubble18)
    }
    
    func moveBubble(){
        if index < bubbles.count {
            addChild(bubbles[index])
            height = bubbles[index].height + 5
            if index != 0 {
                for i in 0..<index{
                    bubbles[i].run(SKAction.moveBy(x: 0, y: height, duration: 0.5))
                }
            }
            bubbles[index].alpha = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.bubbles[self.index-1].run(SKAction.fadeAlpha(to: 1, duration: 0.3))
            }
            index += 1

        }
    }
}

extension SKTexture
{
    
    convenience init(linearGradientWithAngle angleInRadians: CGFloat, colors: [UIColor], locations: [CGFloat], size: CGSize)
    {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { (context) in
            let colorSpace = context.cgContext.colorSpace ?? CGColorSpaceCreateDeviceRGB()
            let cgColors = colors.map({ $0.cgColor }) as CFArray
            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors, locations: UnsafePointer<CGFloat>(locations)) else {
                fatalError("Failed creating gradient.")
            }
            
            let angles = [angleInRadians + .pi, angleInRadians]
            let radius = (pow(size.width / 2.0, 2.0) + pow(size.height / 2.0, 2.0)).squareRoot()
            let points = angles.map { (angle) -> CGPoint in
                let dx = radius * cos(-angle) + size.width / 2.0
                let dy = radius * sin(-angle) + size.height / 2.0
                return CGPoint(x: dx, y: dy)
            }
            
            context.cgContext.drawLinearGradient(gradient, start: points[0], end: points[1], options: [])
        }
        
        self.init(image: image)
    }
}
