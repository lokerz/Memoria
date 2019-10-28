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
    var minHeight : Float = 0.0
    var maxHeight : Float = 0.0
    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3, minHeight : Float, maxHeight : Float) {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/pillar.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.position = position
        self.scale = SCNVector3Make(0.8, 1, 0.8)
        self.minHeight = minHeight
        self.maxHeight = maxHeight
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func move(by translation : CGPoint){
        let currentVal = Int(translation.x)
        
        if currentVal > lastVal {
            let position = self.position.y + yVelocity
            self.position.y = position >= maxHeight ? maxHeight : position
        } else if currentVal < lastVal {
            let position = self.position.y - yVelocity
            self.position.y = position <= minHeight ? minHeight : position
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
