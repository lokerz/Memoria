//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Platform : Pillar{
    var lastVal = 0
    var yVelocity : Float = 0.01
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
        self.name = "Platform"
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
    
}
