//
//  GearPath.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 12/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import GameplayKit

class HalfGearPath : HalfGear {
    var coordinates = [SCNVector3]()
    var nodes = [GKGraphNode]()
    var firstNode : GKGraphNode?
    var lastNode : GKGraphNode?
    var radius : Float = 1.9
    
    override func synchronize() {
        super.synchronize()
        checkRotation()
    }
    
    func setupPath(){
        setupCoordinates()
        setupNodes()
        swapNodes(4, with: 7)
    }
    
    func setupCoordinates(){
        let initialAngle = -180
        let incrementAngle = 45
        for i in 0...7 {
            coordinates.append(calculateCoordinate(from: position, with: radius, rotation: Float(initialAngle + i * incrementAngle)))
        }
                
    }
    
    func setupNodes(){
        for _ in 0..<coordinates.count{
            nodes.append(GKGraphNode())
        }
        for i in 0..<nodes.count - 1{
            nodes[i].addConnections(to: [nodes[i+1]], bidirectional: true)
        }
    }
    
    func swapNodes(_ indexA : Int, with indexB : Int){
        let temp = coordinates[indexA]
        coordinates[indexA] = coordinates[indexB]
        coordinates[indexB] = temp
        
        let temp2 = nodes[indexA]
        nodes[indexA] = nodes[indexB]
        nodes[indexB] = temp2
    }
    
    func checkRotation(){
        let angle = eulerAngles.y
        let degreeAngle = GLKMathRadiansToDegrees(angle)
        
        print(degreeAngle)
        if degreeAngle <= maxAngle-39 && degreeAngle >= minAngle+39 {
            nodes[3].removeConnections(to: [nodes[2]], bidirectional: true)
            nodes[6].removeConnections(to: [nodes[5]], bidirectional: true)
        } else{
            nodes[3].addConnections(to: [nodes[2]], bidirectional: true)
            nodes[6].addConnections(to: [nodes[5]], bidirectional: true)
        }
        
        if angle >= maxAngle - 0.001{
            pathManager.addConnection(from: nodes[7], with: .finishNode)
        } else if angle <= minAngle + 0.001{
            pathManager.addConnection(from: nodes[7], with: .finishNode)
        } else {
            pathManager.removeConnection(from: nodes[7], with: .finishNode)
        }
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
