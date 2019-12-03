//
//  SCNNodeHelper.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 29/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

extension SCNNode {
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
