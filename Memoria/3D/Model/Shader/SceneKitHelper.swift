//
//  SceneKitHelper.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 02/12/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

extension SCNNode{
    func duplicateNode(_ node: SCNNode) -> SCNNode {
//        let scaleFactor : Float = 1.03
        let nodeCopy = node.copy() as? SCNNode ?? SCNNode()
        if let geometry = node.geometry?.copy() as? SCNGeometry {
            nodeCopy.geometry = geometry
            let material = SCNMaterial()
            nodeCopy.geometry?.materials = [material]
        }
//        nodeCopy.scale =  SCNVector3Make(scaleFactor * node.scale.x, scaleFactor * node.scale.y, scaleFactor * node.scale.z)

        let outlineProgram = SCNProgram()
        outlineProgram.vertexFunctionName = "outline_vertex"
        outlineProgram.fragmentFunctionName = "outline_fragment"
        node.geometry?.firstMaterial?.program = outlineProgram
        node.geometry?.firstMaterial?.cullMode = .front
        
        return nodeCopy
    }
}
