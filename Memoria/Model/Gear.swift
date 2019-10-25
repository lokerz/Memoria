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
    var isHaptic = false
    var gearNode = SCNNode()
    var beginningPosition = SCNVector3()
    
    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3, with rotation : SCNVector4 ) {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/gear.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        beginningPosition = position
        gearNode = childNodes.first!
        gearNode.position = position
        gearNode.rotation = rotation
        currentAngle = rotation.w
        print(currentAngle)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func rotateGear(from hitResult : SCNHitTestResult, by translation : CGPoint){
        newAngle = Float(translation.x) * Float(Double.pi / 180)
        newAngle = hitResult.worldCoordinates.z > 0 ? newAngle : 0
        newAngle = newAngle / 3
        newAngle += currentAngle
        gearNode.eulerAngles.y = newAngle
        degreeAngle = Int(newAngle * 57.296)
        if newAngle != 0 {
            haptic()
        }
    }
    
    func haptic(){
        print(degreeAngle)
        
        if (degreeAngle % 20 == 0) && isHaptic{
            HapticGenerator().play(4)
        }
    }
    
    func synchronize(){
        currentAngle = newAngle
    }
    
    func lock(){
//        gearNode.physicsBody!.velocity = SCNVector3Zero
        gearNode.position = beginningPosition
    }
}
