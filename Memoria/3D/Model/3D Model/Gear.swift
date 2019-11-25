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
    var minAngle : Float = 0.0
    var maxAngle : Float = 0.0
    
    var isHaptic = true
    var isRotating = true
    var isCounterRotate = false
    
    var pathManager = PathfindingManager.instance

    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3, with rotation : SCNVector4 ) {
        super.init()
        commonInit(on: position, with: rotation)
    }
    
    init(on position : SCNVector3, with rotation : SCNVector4, minAngle : Float, maxAngle : Float) {
        super.init()
        commonInit(on: position, with: rotation)
        self.minAngle = minAngle
        self.maxAngle = maxAngle
    }
    
    func commonInit(on position : SCNVector3, with rotation :  SCNVector4){
        guard let object = SCNScene(named: "art.scnassets/gear.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.name = "Gear"
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
        newAngle = newAngle * angularVelocity
        newAngle += currentAngle
        newAngle = checkAngle()
        
        self.eulerAngles.y = newAngle
        haptic(eulerAngles.y)
    }
    
    func rotateGear(by degree : Float){
        newAngle = isCounterRotate ? -GLKMathDegreesToRadians(degree) : GLKMathDegreesToRadians(degree)
        
        newAngle += currentAngle

        if maxAngle != 0.0 && minAngle != 0.0 {
            if newAngle > maxAngle {
                isCounterRotate = true
            } else if newAngle < minAngle{
                isCounterRotate = false
            }
        }
        self.eulerAngles.y = newAngle
        synchronize()
    }
    
    func checkAngle() -> Float{
        if maxAngle != 0.0 && minAngle != 0.0 {
            if newAngle > maxAngle || newAngle < minAngle{
                return newAngle > maxAngle ? maxAngle : minAngle
            }
        }
        return newAngle
    }
    
    func haptic(_ angle : Float){
        let intervalAngle : Float = 15
        let buffer : Float = 0.5
        degreeAngle = GLKMathRadiansToDegrees(angle)
//        print(degreeAngle)

        if (degreeAngle.remainder(dividingBy: intervalAngle) < buffer) && (degreeAngle.remainder(dividingBy: intervalAngle) > -buffer) && isHaptic{
            HapticGenerator.instance.play(value : Int(roundf(degreeAngle)), sharpnessValue: 0.2, intensityValue: 0.8)
        }
    }
    
    func synchronize(){
        currentAngle = newAngle
    }
    
}
