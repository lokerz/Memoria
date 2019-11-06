//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class HalfGear : Gear{    
    
    override init(on position : SCNVector3, with rotation : SCNVector4, minAngle: Float, maxAngle : Float) {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/halfgear.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.name = "Half Gear"
        self.position = position
        self.rotation = rotation
        initialAngle = rotation.w
        currentAngle = initialAngle
        newAngle = initialAngle
        
        self.minAngle = minAngle
        self.maxAngle = maxAngle
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
