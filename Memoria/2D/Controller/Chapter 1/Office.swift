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
        //
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
        addChild(button)
        
        //        for char in text{
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //                monolog.text = monolog.text! + "\(char)"
        //                monolog.removeFromParent()
        //                self.addChild(monolog)
        //            }
        //        }
        
        addBubble()
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
        
        let bubble = Bubble()
        let text = "Hey Albert"
        let width : CGFloat = 150
        let position = CGPoint(x: view!.frame.width/2 + 50, y: view!.frame.height/2)
        bubble.createBubble(position: position, width: width, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text, textColor: .white, textSize : 16)
        bubbles.append(bubble)
        
        let bubble2 = Bubble()
        let text2 = "Yes, James?"
        let width2 : CGFloat = 150
        let position2 = CGPoint(x: view!.frame.width/2 - 10, y: view!.frame.height/2)
        bubble2.createBubble(position: position2, width: width2, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text2, textColor: .white, textSize : 16)
        bubbles.append(bubble2)
        
        
        let bubble3 = Bubble()
        let text3 = "Are you busy after work?"
        let width3 : CGFloat = 150
        let position3 = CGPoint(x: view!.frame.width/2 + 50, y: view!.frame.height/2)
        bubble3.createBubble(position: position3, width: width3, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text3, textColor: .white, textSize : 16)
        bubbles.append(bubble3)
        
        let bubble4 = Bubble()
        let text4 = "Erm.. not really, why?"
        let width4 : CGFloat = 150
        let position4 = CGPoint(x: view!.frame.width/2  - 10, y: view!.frame.height/2)
        bubble4.createBubble(position: position4, width: width4, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text4, textColor: .white, textSize : 16)
        bubbles.append(bubble4)
        
        let bubble5 = Bubble()
        let text5 = "So me and the others want to hang out to release some stress after work, do you wanna join us?"
        let width5 : CGFloat = 150
        let position5 = CGPoint(x: view!.frame.width/2 + 50, y: view!.frame.height/2)
        bubble5.createBubble(position: position5, width: width5, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text5, textColor: .white, textSize : 16)
        bubbles.append(bubble5)
        
        let bubble6 = Bubble()
        let text6 = "Sorry James, I think I'll pass \n Where do you want to go anyways?"
        let width6 : CGFloat = 150
        let position6 = CGPoint(x: view!.frame.width/2 - 10, y: view!.frame.height/2)
        bubble6.createBubble(position: position6, width: width6, bubbleColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), type: .bottomLeft, text: text6, textColor: .white, textSize : 16)
        bubbles.append(bubble6)
        
        let bubble7 = Bubble()
        let text7 = "We want to go to the new restaurant across the office, so how is it? Do you wanna join?"
        let width7 : CGFloat = 150
        let position7 = CGPoint(x: view!.frame.width/2 + 50, y: view!.frame.height/2)
        bubble7.createBubble(position: position7, width: width7, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text7, textColor: .white, textSize : 16)
        bubbles.append(bubble7)
        
        let bubble8 = Bubble()
        let text8 = "It sounds interesting but I'm sorry I cannot join you guys"
        let width8 : CGFloat = 150
        let position8 = CGPoint(x: view!.frame.width/2 - 10, y: view!.frame.height/2)
        bubble8.createBubble(position: position8, width: width8, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text8, textColor: .white, textSize : 16)
        bubbles.append(bubble8)
        
        let bubble9 = Bubble()
        let text9 = "Why? Do you still have stuff to do?"
        let width9 : CGFloat = 150
        let position9 = CGPoint(x: view!.frame.width/2 + 50, y: view!.frame.height/2)
        bubble9.createBubble(position: position9, width: width9, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text9, textColor: .white, textSize : 16)
        bubbles.append(bubble9)
        
        let bubble10 = Bubble()
        let text10 = "Not really, I just don't feel like joining you today."
        let width10 : CGFloat = 150
        let position10 = CGPoint(x: view!.frame.width/2 - 10, y: view!.frame.height/2)
        bubble10.createBubble(position: position10, width: width10, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text10, textColor: .white, textSize : 16)
        bubbles.append(bubble10)
        
        let bubble11 = Bubble()
        let text11 = "C'mon Albert, these past few days you have been so quiet, do you have a problem? You can share it with me if you want."
        let width11 : CGFloat = 150
        let position11 = CGPoint(x: view!.frame.width/2 + 50, y: view!.frame.height/2)
        bubble11.createBubble(position: position11, width: width11, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text11, textColor: .white, textSize : 16)
        bubbles.append(bubble11)
        
        let bubble12 = Bubble()
        let text12 = "I just need a bit of time for myself. \n Yeah, I have something in my mind, but I think I can solve it by myself."
        let width12 : CGFloat = 150
        let position12 = CGPoint(x: view!.frame.width/2 - 10, y: view!.frame.height/2)
        bubble12.createBubble(position: position12, width: width12, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text12, textColor: .white, textSize : 16)
        bubbles.append(bubble12)
        
        let bubble13 = Bubble()
        let text13 = "You should enjoy your life from time to time, I think it would be a pity when you have a very good career but you cannot enjoy it yourself."
        let width13 : CGFloat = 150
        let position13 = CGPoint(x: view!.frame.width/2 + 50, y: view!.frame.height/2)
        bubble13.createBubble(position: position13, width: width13, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text13, textColor: .white, textSize : 16)
        bubbles.append(bubble13)
        
        let bubble14 = Bubble()
        let text14 = "Haha yeah I know, I'll try to enjoy it when the time is right. \n Haha, I think it's still too soon for me to enjoy my time"
        let width14 : CGFloat = 150
        let position14 = CGPoint(x: view!.frame.width/2 - 10, y: view!.frame.height/2)
        bubble14.createBubble(position: position14, width: width14, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text14, textColor: .white, textSize : 16)
        bubbles.append(bubble14)
        
        let bubble15 = Bubble()
        let text15 = "But you know, working too hard is not good for your body and mind"
        let width15 : CGFloat = 150
        let position15 = CGPoint(x: view!.frame.width/2 + 50, y: view!.frame.height/2)
        bubble15.createBubble(position: position15, width: width15, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text15, textColor: .white, textSize : 16)
        bubbles.append(bubble15)
        
        let bubble16 = Bubble()
        let text16 = "Relax, I'm already used to this kind of job."
        let width16 : CGFloat = 150
        let position16 = CGPoint(x: view!.frame.width/2 - 10, y: view!.frame.height/2)
        bubble16.createBubble(position: position16, width: width16, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text16, textColor: .white, textSize : 16)
        bubbles.append(bubble16)
        
        let bubble17 = Bubble()
        let text17 = "Hahaha okay then, if you change your mind, just call me later okay?"
        let width17 : CGFloat = 150
        let position17 = CGPoint(x: view!.frame.width/2 + 50, y: view!.frame.height/2)
        bubble17.createBubble(position: position17, width: width17, bubbleColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), type: .bottomRight, text: text17, textColor: .white, textSize : 16)
        bubbles.append(bubble17)
        
        let bubble18 = Bubble()
        let text18 = "Okay.."
        let width18 : CGFloat = 150
        let position18 = CGPoint(x: view!.frame.width/2 - 10, y: view!.frame.height/2)
        bubble18.createBubble(position: position18, width: width18, bubbleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), type: .bottomLeft, text: text18, textColor: .white, textSize : 16)
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

//extension String {
//    var characterArray: [Character]{
//        var characterArray = [Character]()
//        for character in String {
//            characterArray.append(character)
//        }
//        return characterArray
//    }
//}
//
//extension UITextView {
//    func typeOn(string: String) {
//        let characterArray = string.characterArray
//        var characterIndex = 0
//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
//            if characterArray[characterIndex] != "$" {
//                while characterArray[characterIndex] == " " {
//                    self.text.append(" ")
//                    characterIndex += 1
//                    if characterIndex == characterArray.count {
//                        timer.invalidate()
//                        return
//                    }
//                }
//                self.text.append(characterArray[characterIndex])
//            }
//            characterIndex += 1
//            if characterIndex == characterArray.count {
//                timer.invalidate()
//            }
//        }
//    }
//}
