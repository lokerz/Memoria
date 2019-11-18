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
    let fontName = "Helvetica Neue Light"
    let margin : CGFloat = 10
    let fontSize : CGFloat = 10
    
    var shapeNode = SKShapeNode()
    
    func createBubble(position: CGPoint, width : CGFloat, bubbleColor: UIColor, type : bubbleType, text : String, textColor : UIColor, textSize : CGFloat) {
        let size = CGSize(width: width, height: 0)
        
        self.position = position
        self.size = size
        setupBubble(type: type, size : calculateSize(for: text, with : textColor, size: textSize), color : bubbleColor)

    }
    
    func setupBubble(type : bubbleType, size : CGSize, color : UIColor){
        shapeNode = SKShapeNode(path: createPath(type, size).cgPath)
        shapeNode.fillColor = color
        shapeNode.strokeColor = color
        addChild(shapeNode)
    }
    
    func calculateSize(for text : String, with color: UIColor, size : CGFloat) -> CGSize{
        let textNode = SKLabelNode(text: text)
        textNode.fontName = fontName
        textNode.horizontalAlignmentMode = .left
        textNode.verticalAlignmentMode = .center
        textNode.fontSize = fontSize
        textNode.numberOfLines = 0
        textNode.preferredMaxLayoutWidth = self.frame.width - margin
        textNode.color = color
        addChild(textNode)
        

        let constraintRect = CGSize(width: self.frame.width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: nil,
                                            context: nil)
        
        let bubbleSize = CGSize(width: ceil(boundingBox.width) + margin,
                                     height: ceil(boundingBox.height) + margin)
        
        textNode.position = CGPoint(x: margin, y: bubbleSize.height/2)

        return(bubbleSize)
    }
    
    
    func createPath(_ type : bubbleType, _ size : CGSize) -> UIBezierPath{
        let bezierPath = UIBezierPath()
        let width = size.width
        let height = size.height
        let cornerRadius : CGFloat = 10
        
        let points = [
        CGPoint(x: 0, y: cornerRadius), //0
        CGPoint(x: 0, y: 0),            //1 kiri bawah
        CGPoint(x: cornerRadius, y: 0), //2

        CGPoint(x: width - cornerRadius, y: 0), //3
        CGPoint(x: width, y: 0),                //4 kanan bawah
        CGPoint(x: width, y: cornerRadius),     //5
        
        CGPoint(x: width, y: height - cornerRadius), //6
        CGPoint(x: width, y: height),                //7 kanan atas
        CGPoint(x: width - cornerRadius, y: height), //8
        
        CGPoint(x: cornerRadius, y: height),     //9
        CGPoint(x: 0, y: height),                //10 kiri atas
        CGPoint(x: 0, y: height - cornerRadius), //11
        ]
        
        let controlPoints = [
        CGPoint(x: 0, y: cornerRadius/2), //0
        CGPoint(x: cornerRadius/2, y: 0), //1 kiri bawah
        
        CGPoint(x: width - cornerRadius/2, y: 0),   //2
        CGPoint(x: width, y: cornerRadius/2),       //3 kanan bawah
        
        CGPoint(x: width, y: height - cornerRadius/2),  //4
        CGPoint(x: width - cornerRadius/2, y: height),  //5 kanan atas
        
        CGPoint(x: cornerRadius/2, y: height),      //6
        CGPoint(x: 0, y: height - cornerRadius/2)   //7 kiri atas
        ]
        
        if type == .bottomLeft {
            bezierPath.move(to : points[1])
            bezierPath.addLine(to: points[3] )
            bezierPath.addCurve(to: points[5] , controlPoint1: controlPoints[2], controlPoint2: controlPoints[3])
            bezierPath.addLine(to: points[6])
            bezierPath.addCurve(to: points[8], controlPoint1: controlPoints[4], controlPoint2: controlPoints[5])
            bezierPath.addLine(to: points[9] )
            bezierPath.addCurve(to: points[11] , controlPoint1: controlPoints[6], controlPoint2: controlPoints[7] )
        } else if type == .bottomRight {
            bezierPath.move(to : points[4])
            bezierPath.addLine(to: points[6] )
            bezierPath.addCurve(to: points[8] , controlPoint1: controlPoints[4], controlPoint2: controlPoints[5])
            bezierPath.addLine(to: points[9])
            bezierPath.addCurve(to: points[11], controlPoint1: controlPoints[6], controlPoint2: controlPoints[7])
            bezierPath.addLine(to: points[0] )
            bezierPath.addCurve(to: points[2] , controlPoint1: controlPoints[0], controlPoint2: controlPoints[1] )
        } else if type == .upperLeft {
            bezierPath.move(to : points[10])
            bezierPath.addLine(to: points[0] )
            bezierPath.addCurve(to: points[2] , controlPoint1: controlPoints[0], controlPoint2: controlPoints[1])
            bezierPath.addLine(to: points[3])
            bezierPath.addCurve(to: points[5], controlPoint1: controlPoints[2], controlPoint2: controlPoints[3])
            bezierPath.addLine(to: points[6] )
            bezierPath.addCurve(to: points[8] , controlPoint1: controlPoints[4], controlPoint2: controlPoints[5] )
        } else {
            bezierPath.move(to : points[7])
            bezierPath.addLine(to: points[9] )
            bezierPath.addCurve(to: points[11] , controlPoint1: controlPoints[6], controlPoint2: controlPoints[7])
            bezierPath.addLine(to: points[0])
            bezierPath.addCurve(to: points[2], controlPoint1: controlPoints[0], controlPoint2: controlPoints[1])
            bezierPath.addLine(to: points[3] )
            bezierPath.addCurve(to: points[5] , controlPoint1: controlPoints[2], controlPoint2: controlPoints[3] )
        }
        
        bezierPath.close()
        
        return bezierPath
    }
}
