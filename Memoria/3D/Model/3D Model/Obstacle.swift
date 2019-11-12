//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Obstacle : SCNNode{
    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3) {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/obstacle.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.position = position
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
