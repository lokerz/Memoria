//
//  Bubble.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 15/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

enum bubbleType {
    case upperLeft
    case upperRight
    case bottomLeft
    case bottomRight
}
class Bubble : SKSpriteNode {
    var height : CGFloat = 0
    let fontName = "Signika"
    let cornerRadius : CGFloat = 20
    let space : CGFloat = 5
    
    var bubbleNode = SKShapeNode()
    var heights = [CGFloat]()
    
    
    func createChoiceBubble(position: CGPoint, width : CGFloat, bubbleColor: UIColor, type : bubbleType, choices : [String], textColor : UIColor, textSize : CGFloat){
        let size = CGSize(width: width, height: 0)
        
        self.position = position
        self.size = size
        setupBubble(type: type, size: calculateSize(for: choices, textSize: textSize, bubbleSize : size), color: bubbleColor)

        for i in 0..<choices.count {
            addChoice(index : i, type : type, text: choices[i], with: textColor, size: textSize)
        }
        
    }

    func createBubble(position: CGPoint, width : CGFloat, bubbleColor: UIColor, type : bubbleType, text : String, textColor : UIColor, textSize : CGFloat) {
        let size = CGSize(width: width, height: 0)
        
        self.position = position
        self.size = size
        setupBubble(type: type, size : calculateSize(for: text, textSize: textSize, bubbleSize : size), color : bubbleColor)
        addText(type : type, text : text,  with : textColor, size: textSize)
    }
    
    func setupBubble(type : bubbleType, size : CGSize, color : UIColor){
        bubbleNode = SKShapeNode(path: createPath(type, size).cgPath)
        bubbleNode.fillColor = color
        bubbleNode.strokeColor = color
        addChild(bubbleNode)
    }
    
    func addText(type : bubbleType, text : String, with color : UIColor, size : CGFloat){
        let textNode = SKLabelNode(text: text)
        textNode.fontName = fontName
        textNode.horizontalAlignmentMode = .left
        textNode.verticalAlignmentMode = .center
        textNode.fontSize = size
        textNode.numberOfLines = 0
        textNode.preferredMaxLayoutWidth = self.frame.width - cornerRadius * 2 - 5
        textNode.color = color
        switch type {
            case .bottomLeft : textNode.position = CGPoint(x: cornerRadius, y: bubbleNode.frame.height/2)
            case .bottomRight : textNode.position = CGPoint(x: -(bubbleNode.frame.width - cornerRadius), y: bubbleNode.frame.height/2)
            case .upperLeft : textNode.position = CGPoint(x: cornerRadius, y: -bubbleNode.frame.height/2)
            default : textNode.position = CGPoint(x: -(bubbleNode.frame.width - cornerRadius), y: -bubbleNode.frame.height/2)
        }
        bubbleNode.addChild(textNode)
    }
    
    func addChoice(index : Int, type : bubbleType, text : String, with color : UIColor, size : CGFloat){
        print(bubbleNode.frame.height, heights)
        let textNode = SKLabelNode(text: text)
        textNode.fontName = fontName
        textNode.horizontalAlignmentMode = .left
        textNode.verticalAlignmentMode = .top
        textNode.fontSize = size
        textNode.numberOfLines = 0
        textNode.preferredMaxLayoutWidth = self.frame.width - cornerRadius * 2 - 5
        textNode.color = color
        let height = index > 0 ? heights[index - 1] : 0
        switch type {
            case .bottomLeft : textNode.position = CGPoint(x: cornerRadius, y: bubbleNode.frame.height - (cornerRadius + height))
            case .bottomRight : textNode.position = CGPoint(x: -(bubbleNode.frame.width - cornerRadius), y: bubbleNode.frame.height - (cornerRadius + height))
            case .upperLeft : textNode.position = CGPoint(x: cornerRadius, y: -(cornerRadius + height))
            default : textNode.position = CGPoint(x: -(bubbleNode.frame.width - cornerRadius), y: -(cornerRadius + height))

        }
        
        bubbleNode.addChild(textNode)
    }
    
    func createBoundingBox(for text : String, textSize : CGFloat, bubbleSize : CGSize) -> CGRect{
        let constraintRect = CGSize(width: bubbleSize.width - cornerRadius * 2,
                                    height: .greatestFiniteMagnitude)
        let label =  UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: fontName, size: textSize)
        label.text = text
        
        return text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font : label.font],
                                            context: nil)
    }
    
    func calculateSize(for text : String, textSize : CGFloat, bubbleSize : CGSize) -> CGSize{
        let boundingBox = createBoundingBox(for: text, textSize: textSize, bubbleSize : size)
        let bubbleSize = CGSize(width: ceil(boundingBox.width) + cornerRadius * 2,
                                     height: ceil(boundingBox.height) + cornerRadius * 2)
        
        height = bubbleSize.height
        
        return(bubbleSize)
    }
    
    func calculateSize(for texts : [String], textSize : CGFloat, bubbleSize : CGSize) -> CGSize{
        
        var maxWidth : CGFloat = 0
        
        for i in 0..<texts.count{
            let boundingBox = createBoundingBox(for: texts[i], textSize: textSize, bubbleSize : size)
            
            let width = ceil(boundingBox.width) + cornerRadius * 2
            let height = ceil(boundingBox.height)
            
            maxWidth = width > maxWidth ? width : maxWidth
            self.height += height + space
            heights.append(self.height)
        }
        self.height += cornerRadius * 2
        let bubbleSize = CGSize(width: maxWidth, height: self.height)
        return(bubbleSize)
    }
    
    
    func createPath(_ type : bubbleType, _ size : CGSize) -> UIBezierPath{
        let bezierPath = UIBezierPath()
        
        if type == .bottomLeft {
            return drawPath(bezierPath : bezierPath, size : size, a : 1, b : 1)
        } else if type == .bottomRight {
            return drawPath(bezierPath : bezierPath, size : size, a : -1, b : 1)
        } else if type == .upperRight {
            return drawPath(bezierPath : bezierPath, size : size, a : -1, b : -1)
        } else {
            return drawPath(bezierPath : bezierPath, size : size, a : 1, b : -1)
        }
    }
    
    func drawPath(bezierPath : UIBezierPath, size: CGSize, a: CGFloat, b : CGFloat) -> UIBezierPath{
        let width = size.width
        let height = size.height
        
        bezierPath.move(to : CGPoint.zero)
        bezierPath.addLine(to: CGPoint(x: a * (width - cornerRadius), y: 0))
        bezierPath.addCurve(to: CGPoint(x: a * width, y: b * cornerRadius), controlPoint1: CGPoint(x: a * (width - cornerRadius/2), y: 0), controlPoint2: CGPoint(x: a * width, y: b * cornerRadius/2))
        bezierPath.addLine(to: CGPoint(x: a * width, y: b * (height - cornerRadius)))
        bezierPath.addCurve(to: CGPoint(x: a * (width - cornerRadius), y: b * height), controlPoint1: CGPoint(x: a * width, y: b * (height - cornerRadius/2)), controlPoint2: CGPoint(x: a * (width - cornerRadius/2), y: b * height))
        bezierPath.addLine(to: CGPoint(x: a * cornerRadius, y: b * height))
        bezierPath.addCurve(to: CGPoint(x: 0, y: b * (height - cornerRadius)), controlPoint1: CGPoint(x: a * cornerRadius/2, y: b * height), controlPoint2: CGPoint(x: 0, y: b * (height - cornerRadius/2)))
        bezierPath.close()
        
        return bezierPath
    }
}
