//
//  Monologue.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 27/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SpriteKit

class Monologue : SKSpriteNode {
    
    let monologue = SKLabelNode()

    init(){
        let texture = SKTexture()
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    
    init(for skView  : SKView) {
        let texture = SKTexture()
        super.init(texture: texture, color: .clear, size: texture.size())
        
        let bgImage = createGradient(with : skView)
        let window = SKSpriteNode(texture: SKTexture(image: bgImage))
        window.zPosition = 3
        window.anchorPoint = CGPoint(x: 0, y: 0)
        window.position = CGPoint(x: 0, y: skView.frame.height - window.frame.height)
        
        monologue.horizontalAlignmentMode = .left
        monologue.verticalAlignmentMode = .center
        monologue.preferredMaxLayoutWidth = skView.frame.width - 200
        monologue.fontSize = 16
        monologue.numberOfLines = 2
        monologue.position.x = 100
        monologue.position.y = skView.frame.height - 35
        monologue.zPosition = 4
        monologue.fontColor = .black
        monologue.fontName = "Signika"
//
//        let monologueName = SKLabelNode()
//        monologueName.text = "Elio"
//        monologueName.horizontalAlignmentMode = .left
//        monologueName.position = CGPoint(x: 100, y: skView.frame.height - 30)
//        monologueName.fontSize = 22
//        monologueName.fontName = "Roboto-Medium"
//        monologueName.fontColor = .black
//        monologueName.zPosition = 4
        
        self.addChild(window)
        self.addChild(monologue)
//        self.addChild(monologueName)
        self.alpha = 0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeText(to text: String){
        monologue.text = text
    }
    
    func fadeIn(){
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.5)
        self.run(fadeIn)
    }
    
    func fadeOut(){
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.5)
        self.run(fadeOut)
    }
    
    func createGradient(with skView : SKView) -> UIImage{
        let frame = CGRect(x: 0, y: 0, width: skView.frame.width, height: skView.frame.height/3)
        let view = UIView(frame: frame)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0.75).cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradientLayer.locations = [0.25, 0.5, 1]
        
        
        view.layer.addSublayer(gradientLayer)
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let bgImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return bgImage!
    }
    
}
