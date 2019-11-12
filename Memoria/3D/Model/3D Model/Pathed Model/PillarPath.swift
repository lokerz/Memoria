//
//  PillarPath.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 12/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import GameplayKit

class PillarPath : Pillar {
    var coordinates = [SCNVector3]()
    var nodes = [GKGraphNode]()
    var firstNode : GKGraphNode?
    var lastNode : GKGraphNode?
    
    func setupCoordinates(){
        coordinates.append(SCNVector3Make(position.x, 0, position.z))
    }
    
    func setupNodes(){
        nodes.append(GKGraphNode())
        firstNode = nodes.first
        lastNode = nodes.first
    }
}
