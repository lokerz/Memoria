//
//  GearPath.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 12/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import GameplayKit

class GearPath : Gear {
    var coordinates = [SCNVector3]()
    var nodes = [GKGraphNode]()
    var firstNode : GKGraphNode?
    var lastNode : GKGraphNode?
    var radius : Float = 2
    
    func setupCoordinates(){
        let initialAngle = -180
        let incrementAngle = 45
        for i in 0...7 {
            coordinates.append(calculateCoordinate(from: position, with: radius, rotation: Float(initialAngle + i * incrementAngle)))
        }
        
        print(coordinates)
        
    }
    
    func setupNodes(){
        for _ in 0..<coordinates.count{
            nodes.append(GKGraphNode())
        }
        for i in 0..<nodes.count - 1{
            nodes[i].addConnections(to: [nodes[i+1]], bidirectional: true)
        }
        nodes.first!.addConnections(to: [nodes.last!], bidirectional: true)
        
        firstNode = nodes.first
        lastNode = nodes[4]
    }
    
    func calculateCoordinate(from position : SCNVector3, with radius : Float, rotation: Float ) -> SCNVector3{
        let coordinate = SCNVector3Make(
            position.x + (radius * cos(GLKMathDegreesToRadians(rotation))),
            0,
            position.z + (radius * sin(GLKMathDegreesToRadians(rotation)))
        )
        
        return coordinate
    }
}
