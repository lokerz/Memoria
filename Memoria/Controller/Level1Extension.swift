//
//  Level1Extension.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 22/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

extension GameViewController {
    
    func setupLevelOne(){
        setupLevelOneChild()
    }
    
    func setupLevelOneChild(){
            let playerLocation = SCNVector3Make(-5, 2, 0)
            let gearOneLocation = SCNVector3Make(-3, 0, 0)
            let gearOneRotation = SCNVector4Make(0, 0, 0, 0)
            let gearTwoLocation = SCNVector3Make(2.3, 0, 0)
            let gearTwoRotation = SCNVector4Make(0, 1, 0, 0.3)

            
            player = Player(on: playerLocation)
            gear = Gear(on: gearOneLocation, with: gearOneRotation)
            gear2 = Gear(on: gearTwoLocation, with: gearTwoRotation)
            
            sceneView.scene?.rootNode.addChildNode(player)
            sceneView.scene?.rootNode.addChildNode(gear)
            sceneView.scene?.rootNode.addChildNode(gear2)

        }
       
}
