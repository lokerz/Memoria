//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class HalfGear : SCNNode{
    var angularVelocity : Float = 0.3
    var initialAngle : Float = 0.0
    var degreeAngle : Float = 0
    var currentAngle : Float = 0.0
    var newAngle : Float = 0.0
    var minAngle : Float = 0.0
    var maxAngle : Float = 0.0
    
    var isRotateAble = true
    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3, with rotation : SCNVector4, minAngle: Float, maxAngle : Float) {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/halfgear.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.position = position
        self.rotation = rotation
        initialAngle = rotation.w
        currentAngle = initialAngle
        newAngle = initialAngle
        
        self.minAngle = minAngle
        self.maxAngle = maxAngle
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func rotateGear(from hitResult : SCNHitTestResult, by translation : CGPoint){
        //0.60 , -0.52
        newAngle = Float(translation.x) * Float(Double.pi / 180)
        newAngle = hitResult.worldCoordinates.z > 0 ? newAngle : 0
        newAngle = newAngle * angularVelocity
        newAngle += currentAngle
        if newAngle > maxAngle || newAngle < minAngle{
            isRotateAble = false
            newAngle = newAngle > maxAngle ? maxAngle : minAngle
        }
        self.eulerAngles.y = newAngle
        print(eulerAngles.y)
    }
    func synchronize(){
        currentAngle = newAngle
    }
    
}
