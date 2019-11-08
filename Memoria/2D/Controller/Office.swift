//
//  Office.swift
//  Memoria
//
//  Created by Delvin on 04/11/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import SpriteKit

class Office: SKScene{
    
    let button = SKSpriteNode(imageNamed: "nextButton")
    let border = SKSpriteNode()
    
    override func didMove(to view: SKView) {

        let linearGradientSize = size
        let linearGradientColors = [UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1),
                                    UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.5),
                                    UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0)]
        let linearGradientLocations: [CGFloat] = [0, 0.5, 1]
        let textureCount = 8
        let textures = (0..<textureCount).map { (index) -> SKTexture in
            let angle : CGFloat = 33/7
          return SKTexture(linearGradientWithAngle: angle, colors: linearGradientColors, locations: linearGradientLocations, size: linearGradientSize)
        }
            
        let border = SKSpriteNode(texture: textures.first)
        border.zPosition = 1
        border.anchorPoint = CGPoint(x: 0.5, y: 0)
        border.size = CGSize(width: view.frame.width, height: view.frame.height/4)
        border.position = CGPoint(x: view.frame.width/2, y: 3*view.frame.height/4)
        
        let text = SKLabelNode(text: "Hello World, Lorem Ipsum is not a word, why are you reading this, Go back to work!!!")
        
        text.zPosition = 2
        text.fontSize = 16
        text.fontColor = .black
        text.fontName = "Times New Roman"
        text.position = CGPoint(x: view.frame.width/2, y: 6*view.frame.height/7)
        text.numberOfLines = 3
        text.preferredMaxLayoutWidth = view.frame.width-100
        
        button.position = CGPoint(x:view.frame.width-60, y: 60)
        button.zPosition = 1
        button.name = "nextButton"
        button.setScale(0.4)
        
        addChild(border)
        addChild(button)
        addChild(text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let location = touch.location(in: self)
        let nodesarray = nodes(at: location)

            for node in nodesarray {
                if node.name == "nextButton"{
                    let fifthPage = FrontHouse(fileNamed: "FrontHouse")
                    fifthPage?.scaleMode = .resizeFill
                    self.view?.presentScene(fifthPage!, transition: SKTransition.fade(withDuration: 0.5))
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
