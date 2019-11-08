//
//  Light.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 28/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Light {
    let node: SCNNode
    let lumen : CGFloat = 100
    let temperature : CGFloat = 6500
    
    init(position: SCNVector3, orientation: SCNVector3, color: UIColor) {
        node = SCNNode()
        node.light = SCNLight()
        node.light?.color = color
        node.position = position
        node.eulerAngles = orientation
        node.light?.type = .directional
        node.light?.intensity = lumen
        node.light?.temperature = temperature
        activateShadow()
    }
    
    private func activateShadow() {
        node.light?.castsShadow = true
        node.light?.orthographicScale = 10
    }
}
