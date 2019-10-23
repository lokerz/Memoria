//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Gear : SCNNode{
    var degreeAngle = 0
    var currentAngle : Float = 0.0
    var newAngle : Float = 0.0
    var gearNode = SCNNode()
    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3, with rotation : SCNVector4 ) {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/gear.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.position = position
        self.rotation = rotation
//        currentAngle = rotation.w
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    func rotateGear(from hitResult : SCNHitTestResult, by translation : CGPoint){
//        newAngle = Float(translation.x) * Float(Double.pi / 180) * 0.25
//        newAngle = hitResult.worldCoordinates.z > 0 ? newAngle : -newAngle
//        newAngle += currentAngle
//        self.eulerAngles.y = newAngle
//        degreeAngle = Int(newAngle * 57.296 * 4)
//        haptic()
//
//    }
//
    func rotateGear(from hitResult : SCNHitTestResult, by translation : CGPoint){
        let x = Float(translation.x)
        let y = Float(-translation.y)
        let anglePan = (sqrt(pow(x,2)+pow(y,2)))*(Float)(Double.pi)/180.0 / 10

        var rotationVector = SCNVector4()
        rotationVector.x = 0.0
        rotationVector.y = x
        rotationVector.z = 0.0
        rotationVector.w = anglePan
        
        for child in self.childNodes{
//            child.physicsBody?.angularVelocity = rotationVector
            child.rotation = rotationVector
        }
        
        print(#function, rotationVector)
        
    }
    
    func haptic(){
        print(degreeAngle)
        print(gearNode.physicsBody?.angularVelocity)
        if (degreeAngle % 30 < 1) && (degreeAngle % 30 > -1){
            HapticGenerator().play(4)
        }
    }
//
//    func synchronize(){
//        currentAngle = newAngle
//    }
}
