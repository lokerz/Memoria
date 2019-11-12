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
    var radius : Float = 1.75
    
    override func rotateGear(from hitResult: SCNHitTestResult, by translation: CGPoint) {
        super.rotateGear(from: hitResult, by: translation)
        checkRotation()
    }
    
    func setupPath(){
        setupCoordinates()
        setupNodes()
    }
    
    func setupCoordinates(){
        let initialAngle = 45
        let incrementAngle = 45
        for i in 0...6 {
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
        
//        nodes.first?.removeConnections(to: <#T##[GKGraphNode]#>, bidirectional: <#T##Bool#>)
        
        firstNode = nodes[3]
        lastNode = nodes[6]
    }
    
    func checkRotation(){
        let finishNode = pathManager.finishNode
        let angle = GLKMathRadiansToDegrees(eulerAngles.y)
        
        if angle > 30 {
            nodes[0].addConnections(to: [finishNode], bidirectional: true) //sambungin 0 dan finish
            nodes[6].removeConnections(to: [finishNode], bidirectional: true) //putusin 6 dan finish
        } else if angle < -32 {
            nodes[0].removeConnections(to: [finishNode], bidirectional: true) //putusin 0 dan finish
            nodes[6].addConnections(to: [finishNode], bidirectional: true) //sambungin 6 dan finish
        } else {
            nodes[0].removeConnections(to: [finishNode], bidirectional: true) //putusin 0 dan finish
            nodes[6].removeConnections(to: [finishNode], bidirectional: true) //putusin 6 dan finish
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
