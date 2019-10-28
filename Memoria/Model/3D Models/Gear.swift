//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Gear : SCNNode{
    var angularVelocity : Float = 0.3
    var initialAngle : Float = 0.0
    var degreeAngle : Float = 0
    var currentAngle : Float = 0.0
    var newAngle : Float = 0.0
    var isHaptic = true
    var isRotating = true
    
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
        initialAngle = rotation.w
        currentAngle = initialAngle
        newAngle = initialAngle
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func rotateGear(from hitResult : SCNHitTestResult, by translation : CGPoint){
        newAngle = Float(translation.x) * Float(Double.pi / 180)
        newAngle = hitResult.worldCoordinates.z > 0 ? newAngle : 0
        newAngle = newAngle * angularVelocity
        newAngle += currentAngle
        self.eulerAngles.y = newAngle
        
        
        if newAngle != 0 {
            haptic(eulerAngles.y)
        }
        
    }
    
    func haptic(_ angle : Float){
        let intervalAngle : Float = 15
        let buffer : Float = 0.5
        degreeAngle = angle * 57.2958

        if (degreeAngle.remainder(dividingBy: intervalAngle) < buffer) && (degreeAngle.remainder(dividingBy: intervalAngle) > -buffer) && isHaptic{
            HapticGenerator.instance.play(value : Int(roundf(degreeAngle)), sharpnessValue: 0.2, intensityValue: 0.8)
        }
    }
    
    func synchronize(){
        currentAngle = newAngle
    }
    
}
