//
//  YellowButton.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 27/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SpriteKit

enum direction {
    case up
    case down
    case left
    case right
}

class YellowButton : SKNode{
    var playBox = SKShapeNode()
    var playText = SKLabelNode()
    var dropShadowPlayBox = SKShapeNode()
    var tempTextPosition = CGPoint.zero
    var tempBoxPosition = CGPoint.zero
    
    override init() {
        super.init()
    }
    
    init(with size: CGSize, text: String, textSize : CGFloat){
        super.init()
        
        playBox = SKShapeNode(rectOf: size)
        dropShadowPlayBox = SKShapeNode(rectOf: size)
        
        let attrs: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Roboto-Black", size: textSize) as Any,
            .kern: 2
        ]
        playText.attributedText = NSAttributedString(string: text, attributes: attrs)
        playText.zPosition = 3
        playText.verticalAlignmentMode = .center
        playText.position = CGPoint(x: self.position.x, y: self.position.y)
        tempTextPosition = playText.position
        
        playBox.fillColor = UIColor.init(red: 255/255, green: 229/255, blue: 139/255, alpha: 1)
        playBox.zPosition = 2
        playBox.position = self.position
        playBox.strokeColor = .black
        tempBoxPosition = playBox.position
        
        dropShadowPlayBox.zPosition = 1
        dropShadowPlayBox.fillColor = .black
        dropShadowPlayBox.strokeColor = .clear
        dropShadowPlayBox.position = CGPoint(x: self.position.x + 5, y: self.position.y - 5)
        
        self.addChild(playBox)
        self.addChild(playText)
        self.addChild(dropShadowPlayBox)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(to direction : direction) {
        let duration = 0.33
        var move = SKAction()
        move.timingMode = .easeIn
        switch direction {
            case .up : move = SKAction.moveBy(x: 0, y: 100, duration: duration)
            case .down : move = SKAction.moveBy(x: 0, y: -100, duration: duration)
            case .left : move = SKAction.moveBy(x: -100, y: 0, duration: duration)
            default : move = SKAction.moveBy(x: 100, y: 0, duration: duration)
        }
        self.run(move)
    }
    
    func highlight(){
//        HapticGenerator.instance.play(sharpnessValue : 0.5, intensityValue : 0.5)

        let offset : CGFloat = 2
        playBox.position = CGPoint(x: playBox.position.x + offset, y: playBox.position.y - offset)
        playText.position = CGPoint(x: playText.position.x + offset, y: playText.position.y - offset)
        playBox.fillColor = UIColor.init(red: 251/255, green: 247/255, blue: 221/255, alpha: 1)

    }
    
    func reset(){
        playBox.position = tempBoxPosition
        playText.position = tempTextPosition
        playBox.fillColor = UIColor.init(red: 255/255, green: 229/255, blue: 139/255, alpha: 1)
    }
}
