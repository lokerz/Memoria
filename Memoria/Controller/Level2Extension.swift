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
    
    func setupLevelTwo(){
        let playerLocation = SCNVector3Make(-7.6, 7.5, 0)
        
        let pillar1Location = SCNVector3Make(-7.6, 4.66, 0)
        
        let gearOneLocation = SCNVector3Make(-3.7, 0, 0)
        let gearOneRotation = SCNVector4Make(0, 0, 0, 0)
                
//        let platformLocation = SCNVector3Make(0, -0.53, 0)
        let platformLocation = SCNVector3Make(0, 3, 0)


        let gearTwoLocation = SCNVector3Make(3.7, 0, 0)
        let gearTwoRotation = SCNVector4Make(0, 1, 0, 0.25)
        
        let finishPillarLocation = SCNVector3Make(7.6, -0.55, 0)

        
        let finishLocation = SCNVector3Make(finishPillarLocation.x, 0, finishPillarLocation.z)
        
        
        player = Player(on: playerLocation)
        player.finishLocation = finishLocation
        let gear = Gear(on: gearOneLocation, with: gearOneRotation)
        let gear2 = Gear(on: gearTwoLocation, with: gearTwoRotation)
        let pillar = Pillar(on : pillar1Location, isFinish : false)
        finishPillar = Pillar(on : finishPillarLocation, isFinish : true)
        let platform = Platform(on: platformLocation)

        
        rootNode.addChildNode(player)
        rootNode.addChildNode(gear)
        rootNode.addChildNode(gear2)
        rootNode.addChildNode(pillar)
        rootNode.addChildNode(platform)
        rootNode.addChildNode(finishPillar)
        
        gears.removeAll()
        gears.append(gear)
        gears.append(gear2)
        
        platforms.removeAll()
        platforms.append(platform)
    }
    
    
    
    func levelTwoPanHandler(_ gestureRecognizer : UIPanGestureRecognizer){
        let location = gestureRecognizer.location(in: sceneView)
        let translation = gestureRecognizer.translation(in: sceneView)
        
        let hitResults = sceneView.hitTest(location, options: [:])
        
        
        if hitResults.count > 0 {
            let pannedPiece = hitResults.first?.node
            
            if pannedPiece == gears[0].childNodes.first {
                gearSystem(gearA: gears[0], gearB: gears[1], relation: .nonInfluence, hitResult: hitResults.first!, translation: translation)
                platformSystem(gear : gears[0], platform: platforms[0], relation: .sameDirection, hitResult : hitResults.first!, translation : translation)
            }
            else if pannedPiece == gears[1].childNodes.first {
                gearSystem(gearA: gears[1], gearB: gears[0], relation: .nonInfluence, hitResult: hitResults.first!, translation: translation)
                platformSystem(gear : gears[1], platform: platforms[0], relation: .oppositeDirection, hitResult : hitResults.first!, translation : translation)
            }
        }
        
        if gestureRecognizer.state == .ended {
            for gear in gears{
                gear.isHaptic = true
                gear.isRotating = true
                gear.synchronize()
            }
        }
    }
    
}
