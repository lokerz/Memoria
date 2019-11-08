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
    let myGraph = GKGraph()
    var nodes = [GKGraphNode]()
    var coordinates = [SCNVector3]()
    
    override init() {
        super.init()
        setupCoordinates()
        setupNodes()
    }
    
    func setupNodes(){
        
    }
    
    func setupCoordinates(){
        
    }
    
    func findPath() -> [SCNVector3]{
        setupCoordinates()
        setupNodes()
        
        var path = [SCNVector3]()
        for graphNode in myGraph.findPath(from: nodes[0], to: nodes[12]) {
            path.append(coordinates[nodes.firstIndex(of: graphNode)!])
        }
        return path
    }
    
    
    func calculateNode(from position: SCNVector3, to destination: SCNVector3) -> [SCNVector3]{
        var path = [SCNVector3]()
                
        //Find nearest Node to position
        var distance = calculateDistance(from: position, to: coordinates.first!)
        var firstNodeIndex = 0
        for i in 1..<coordinates.count{
            let temp = calculateDistance(from: position, to: coordinates[i])
            if temp < distance {
                firstNodeIndex = i
                distance = temp
            }
        }
        
        //Find nearest Node to Destination
        var lastNodeIndex = 0
        distance = calculateDistance(from: destination, to: coordinates.first!)
        for i in 1..<coordinates.count{
            let temp = calculateDistance(from: destination, to: coordinates[i])
            if temp < distance {
                lastNodeIndex = i
                distance = temp
            }
        }
        
        //Find the Path
        let nodesInBetween = myGraph.findPath(from: nodes[firstNodeIndex], to: nodes[lastNodeIndex])
        
        //Return the Coordinates
        for node in nodesInBetween {
            path.append(coordinates[nodes.firstIndex(of: node)!])
        }
        
        return path
    }
    
    func calculateDistance(from nodeA: SCNVector3, to nodeB: SCNVector3)  -> Float{
        let node1Pos = SCNVector3ToGLKVector3(nodeA)
        let node2Pos = SCNVector3ToGLKVector3(nodeB)
        let distance = GLKVector3Distance(node1Pos, node2Pos)
        return distance
    }
    
}
