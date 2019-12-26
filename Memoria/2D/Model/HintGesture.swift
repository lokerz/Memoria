//
//  HintGesture.swift
//  Memoria
//
//  Created by Delvin on 23/12/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SpriteKit

class HintGesture : SKNode{
    var hintCircle = SKShapeNode()
    var hintShadow = SKShapeNode()

    override init() {
        super.init()
    }
    
    init(with size: CGFloat){
        super.init()
        
        hintCircle = SKShapeNode(circleOfRadius: size)
        hintShadow = SKShapeNode(circleOfRadius: size)
        
        hintCircle.fillColor = UIColor.init(red: 246/255, green: 246/255, blue: 255/255, alpha: 1)
        hintCircle.zPosition = 2
        hintCircle.position = self.position
        hintCircle.strokeColor = .clear
        
        hintShadow.zPosition = 1
        hintShadow.fillColor = .black
        hintShadow.strokeColor = .clear
        hintShadow.position = CGPoint(x: self.position.x + 2, y: self.position.y - 2)
        
        self.addChild(hintCircle)
        self.addChild(hintShadow)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func swipe(to direction : direction) {
        let moveDuration = 1.0
        let fadeDuration = 0.5
        let resetPositionDuration = 0.5
        var move = SKAction()
        move.timingMode = .easeInEaseOut
        switch direction {
            case .up : move = SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: fadeDuration),SKAction.moveBy(x: 0, y: 100, duration: moveDuration),SKAction.fadeAlpha(to: 0, duration: fadeDuration),SKAction.moveBy(x: 0, y: -100, duration: resetPositionDuration)])
            case .down : move = SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: fadeDuration),SKAction.moveBy(x: 0, y: -100, duration: moveDuration),SKAction.fadeAlpha(to: 0, duration: fadeDuration),SKAction.moveBy(x: 0, y: 100, duration: resetPositionDuration)])
            case .left : move = SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: fadeDuration),SKAction.moveBy(x: -100, y: 0, duration: moveDuration),SKAction.fadeAlpha(to: 0, duration: fadeDuration),SKAction.moveBy(x: 100, y: 0, duration: resetPositionDuration)])
            case .right : move = SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: fadeDuration),SKAction.moveBy(x: 100, y: 0, duration: moveDuration),SKAction.fadeAlpha(to: 0, duration: fadeDuration),SKAction.moveBy(x: -100, y: 0, duration: resetPositionDuration)])
        default : break
        }
        self.run(SKAction.repeatForever(move))
    }

    func tap(){
        let stayDuration = 1.0
        let fadeDuration = 0.5
        var move = SKAction()
        move.timingMode = .easeInEaseOut
        
        move = SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: fadeDuration),SKAction.wait(forDuration: stayDuration),SKAction.fadeAlpha(to: 0, duration: fadeDuration)])
        self.run(SKAction.repeatForever(move))
    }
    
    func zigzag(point1: CGVector, point2: CGVector, point3: CGVector, point4: CGVector){
        let moveDuration = 0.416
        let fadeDuration = 0.5
        let resetPositionDuration = 0.5
        var move = SKAction()
        
        let resetX = point1.dx + point2.dx + point3.dx + point4.dx
        let resetY = point1.dy + point2.dy + point3.dy + point4.dy
        
        move = SKAction.sequence([
            SKAction.fadeAlpha(to: 1, duration: fadeDuration),
            SKAction.move(by: point1, duration: moveDuration),
            SKAction.move(by: point2, duration: moveDuration),
            SKAction.move(by: point3, duration: moveDuration),
            SKAction.move(by: point4, duration: moveDuration),
            SKAction.fadeAlpha(to: 0, duration: fadeDuration),
            
            SKAction.moveBy(x: -resetX, y: -resetY, duration: resetPositionDuration)
        ])
        
        self.run(SKAction.repeatForever(move))
    }
}

