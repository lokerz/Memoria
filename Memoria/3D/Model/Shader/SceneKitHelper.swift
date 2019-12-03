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
//        let scaleFactor : Float = 0.9
        let nodeCopy = node.copy() as? SCNNode ?? SCNNode()
        if let geometry = node.geometry?.copy() as? SCNGeometry {
            nodeCopy.geometry = geometry
            if let material = geometry.firstMaterial?.copy() as? SCNMaterial {
                nodeCopy.geometry?.firstMaterial = material
            }
        }
//        nodeCopy.scale =  SCNVector3Make(scaleFactor * node.scale.x, scaleFactor * node.scale.y, scaleFactor * node.scale.z)
        
        let outlineProgram = SCNProgram()
        outlineProgram.vertexFunctionName = "outline_vertex"
        outlineProgram.fragmentFunctionName = "outline_fragment"
        node.geometry?.firstMaterial?.program = outlineProgram
        node.geometry?.firstMaterial?.cullMode = .front
        
        return nodeCopy
    }
    
    func setHighlighted( _ highlighted : Bool = true, _ highlightedBitMask : Int = 2 ) {
        categoryBitMask = highlightedBitMask
        for child in self.childNodes {
            child.setHighlighted()
        }
    }
    
    func setupShader(for node : SCNNode){
            let shaders = NSMutableDictionary()
            do {
                shaders[SCNShaderModifierEntryPoint.lightingModel] = try String(contentsOfFile: Bundle.main.path(forResource: "toon_lighting", ofType: "shader")!, encoding: String.Encoding.utf8)
    //            let mod = """
    //            uniform mat4 transform;
    //            uniform mat3 normalMatrix;
    //            uniform vec3 lightNormal;
    //
    //            attribute vec4 vertex;
    //            attribute vec4 color;
    //            attribute vec3 normal;
    //
    //            varying vec4 vertColor;
    //            varying vec3 vertNormal;
    //            varying vec3 vertLightDir;
    //
    //            void main() {
    //              gl_Position = transform * vertex;
    //              vertColor = color;
    //              vertNormal = normalize(normalMatrix * normal);
    //              vertLightDir = -lightNormal;
    //            }
    //            """
                
    //            shaders[SCNShaderModifierEntryPoint.surface] = mod
    //            shaders[SCNShaderModifierEntryPoint.fragment] = try String(contentsOfFile: Bundle.main.path(forResource: "toon_outline", ofType: "shader")!, encoding: String.Encoding.utf8)

            } catch {
                print(error)
            }
            
            if let materialArr  = node.geometry?.materials {
                for material in materialArr{
                    material.shaderModifiers = shaders as? [SCNShaderModifierEntryPoint : String]
                }
            }
        }
}
