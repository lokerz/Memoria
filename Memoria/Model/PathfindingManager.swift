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
    
    func test(){
        let nodeA = GKGraphNode()
        let nodeB = GKGraphNode()
        let nodeC = GKGraphNode()
        let nodeD = GKGraphNode()
        
        nodeA.addConnections(to: [nodeB, nodeD], bidirectional: true)
        nodeC.addConnections(to: [nodeB, nodeD], bidirectional: true)
        
        myGraph.add([nodeA, nodeB, nodeC, nodeD])
        
        print(myGraph.findPath(from: nodeA, to: nodeD))
    }
    
}
