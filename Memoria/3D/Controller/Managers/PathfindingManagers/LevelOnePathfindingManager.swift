//
//  LevelOnePathfindingManager.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 01/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit
import GameplayKit

class LevelOnePathfindingManager : PathfindingManager {
    
    override func setupCoordinates() {
            coordinates.append(SCNVector3Make(-6.68, 0, 0))
            coordinates.append(SCNVector3Make(-4.5, 0, 0))//CGPoint(x: -4.4, y: 0)
            coordinates.append(SCNVector3Make(-3.4, 0, 1.6))//CGPoint(x: -3.4, y: 1.7)
            coordinates.append(SCNVector3Make(-1.6, 0, 1.6))//CGPoint(x: -1.6, y: 1.7)
            coordinates.append(SCNVector3Make(0, 0, 0))//CGPoint(x: 0, y: 0)
            coordinates.append(SCNVector3Make(-1.6, 0, -1.6))//CGPoint(x: -1.6, y: -1.7)
            coordinates.append(SCNVector3Make(-3.4, 0, -1.6))//CGPoint(x: -3.4, y: -1.7)
            coordinates.append(SCNVector3Make(1.6, 0, 1.6))//CGPoint(x: 1.6, y: 1.7)
            coordinates.append(SCNVector3Make(3.4, 0, 1.6))//CGPoint(x: 3.4, y: 1.7)
            coordinates.append(SCNVector3Make(4, 0, 0))//CGPoint(x: 4, y: 0)
            coordinates.append(SCNVector3Make(3.4, 0, -1.6))//CGPoint(x: 3.4, y: -1.7)
            coordinates.append(SCNVector3Make(1.6, 0, -1.6))//CGPoint(x: 1.6, y: -1.7)
            coordinates.append(SCNVector3Make(5.24, 0, 0))//CGPoint(x: 6.24, y: 0)
    }
    
    override func setupNodes() {
        
        for _ in 0..<coordinates.count {
            nodes.append(GKGraphNode())
        }
        myGraph.add(nodes)

        nodes[1].addConnections(to: [nodes[0], nodes[2], nodes[6]], bidirectional: true)
        nodes[3].addConnections(to: [nodes[2], nodes[4]], bidirectional: true)
        nodes[5].addConnections(to: [nodes[4], nodes[6]], bidirectional: true)
        nodes[7].addConnections(to: [nodes[4], nodes[8]], bidirectional: true)
        nodes[11].addConnections(to: [nodes[4], nodes[10]], bidirectional: true)
        nodes[9].addConnections(to: [nodes[8], nodes[10], nodes[12]], bidirectional: true)
        
        
    }
    
    
    
    
}
