//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Platform : SCNNode{
    var lastVal = 0
    var yVelocity : Float = 0.05
    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3) {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/pillar.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.position = position
        self.scale = SCNVector3Make(0.8, 1, 0.8)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func move(by translation : CGPoint){
        let currentVal = Int(translation.x)
        if currentVal > lastVal {
            self.position.y += yVelocity
        } else if currentVal < lastVal {
            self.position.y -= yVelocity
        }
        
        lastVal = Int(translation.x)

        
    }
    
    func rotateGear(from hitResult : SCNHitTestResult, by translation : CGPoint){
//        newAngle = Float(translation.x) * Float(Double.pi / 180)
//        newAngle = hitResult.worldCoordinates.z > 0 ? newAngle : 0
//        newAngle = newAngle * angularVelocity
//        newAngle += currentAngle
//        self.eulerAngles.y = newAngle
//        
//        
//        if newAngle != 0 {
//            haptic(eulerAngles.y)
//        }
//        
    }
    
}
