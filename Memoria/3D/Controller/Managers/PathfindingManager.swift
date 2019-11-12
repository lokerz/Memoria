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

enum nodeType {
    case singlePoint
    case gear
}

class PathfindingManager : NSObject {
    static var instance = PathfindingManager()
    var myGraph = GKGraph()
    var nodes = [GKGraphNode]()
    var coordinates = [SCNVector3]()
    var lastNode = GKGraphNode()
    
    override init() {
        super.init()
        setupCoordinates()
        setupNodes()
    }
    
    func resetPath(){
        myGraph = GKGraph()
        nodes = [GKGraphNode]()
        coordinates = [SCNVector3]()
    }
    
    func appendNode(nodes : [GKGraphNode], lastNode : GKGraphNode, index : Int){
        if index != 0 {
            self.lastNode.addConnections(to: [nodes.first!], bidirectional: true)
        }
        nodes.forEach { node in
            self.nodes.append(node)
        }
        self.lastNode = lastNode
    }
    
    func appendCoordinates(coordinates : [SCNVector3]){
        coordinates.forEach { coordinate in
            self.coordinates.append(coordinate)
        }
    }
    
    func setupNodes(){
        myGraph.add(nodes)
    }
    
    func setupCoordinates(){
        
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
