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
        let rootNode = sceneView.scene!.rootNode
        
        let playerLocation = SCNVector3Make(-6.9, 10, 0)
        
        let gearOneLocation = SCNVector3Make(-2.8, 0, 0)
        let gearOneRotation = SCNVector4Make(0, 0, 0, 0)
        
        let gearTwoLocation = SCNVector3Make(2.35, 0, 0)
        let gearTwoRotation = SCNVector4Make(0, 1, 0, 0.25)
        
        let pillar1Location = SCNVector3Make(-6.8, -0.55, 0)
        let pillar2Location = SCNVector3Make(6.3, -0.55, 0)
        
        
        player = Player(on: playerLocation)
        gear = Gear(on: gearOneLocation, with: gearOneRotation)
        gear2 = Gear(on: gearTwoLocation, with: gearTwoRotation)
        let pillar = Pillar(on : pillar1Location)
        let pillar2 = Pillar(on : pillar2Location)
        
        rootNode.addChildNode(player)
        rootNode.addChildNode(gear)
        rootNode.addChildNode(gear2)
        rootNode.addChildNode(pillar)
        rootNode.addChildNode(pillar2)
        
    }
    
    func level1PanHandler(_ gestureRecognizer : UIPanGestureRecognizer){
        let location = gestureRecognizer.location(in: sceneView)
        let translation = gestureRecognizer.translation(in: sceneView)
        let translation2 = CGPoint(x: -translation.x, y: -translation.y)
        let hitResults = sceneView.hitTest(location, options: [:])
        
        if hitResults.count > 0 {
            let pannedPiece = hitResults.first?.node
            if pannedPiece == gear.childNodes.first {
                gear.isHaptic = true
                gear2.isHaptic = false
                gear.rotateGear(from : hitResults.first!, by: translation)
                gear2.rotateGear(from: hitResults.first!, by: translation2)
            }
            else if pannedPiece == gear2.childNodes.first {
                gear.isHaptic = false
                gear2.isHaptic = true
                gear2.rotateGear(from : hitResults.first!, by: translation)
                gear.rotateGear(from: hitResults.first!, by: translation2)
            }
        }

        if gestureRecognizer.state == .ended {
            gear.isHaptic = false
            gear2.isHaptic = false
            gear.synchronize()
            gear2.synchronize()
        }
    }
    
}
