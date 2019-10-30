//
//  PathfindingManager.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 25/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import GameplayKit
import SceneKit

class PathfindingManager : NSObject {
    static let instance = PathfindingManager()
    
    let myGraph = GKGraph()
    var nodes = [GKGraphNode]()
    
    func setupNode(){
        for i in 0...13 {
            nodes.append(GKGraphNode())
        }
        nodes[1].addConnections(to: [nodes[0], nodes[2], nodes[6]], bidirectional: true)
        nodes[3].addConnections(to: [nodes[2], nodes[4]], bidirectional: true)
        nodes[5].addConnections(to: [nodes[4], nodes[6]], bidirectional: true)
        nodes[7].addConnections(to: [nodes[4], nodes[8], nodes[12]], bidirectional: true)
        nodes[9].addConnections(to: [nodes[8], nodes[10]], bidirectional: true)
        nodes[11].addConnections(to: [nodes[10], nodes[12]], bidirectional: true)
        nodes[13].addConnections(to: [nodes[10]], bidirectional: true)
        
        
        myGraph.add(nodes)
        
        print(myGraph.findPath(from: nodes[0], to: nodes[13]))
        
    }
}
