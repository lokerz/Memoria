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
    
    func setupLevelThree(){
        
        let playerLocation = SCNVector3Make(-6.68, 7.5, 0)
        
        let pillar1Location = SCNVector3Make(-6.68, 4.66, 0)

        let gearOneLocation = SCNVector3Make(-2.78, 0, 0)
        let gearOneRotation = SCNVector4Make(0, 0, 0, 0)
        
        let gearTwoLocation = SCNVector3Make(2.34, 0, 0)
        let gearTwoRotation = SCNVector4Make(0, 0, 0, 0)
        
        let finishPillarLocation = SCNVector3Make(4.29, -0.55, 0)
        
        let finishLocation = SCNVector3Make(finishPillarLocation.x, 0, finishPillarLocation.z)
        
        
        player = Player(on: playerLocation)
        player.finishLocation = finishLocation
        let gear = Gear(on: gearOneLocation, with: gearOneRotation, minAngle: -0.54, maxAngle: 0.61)
        let halfGear = HalfGear(on: gearTwoLocation, with: gearTwoRotation, minAngle: -0.61, maxAngle: 0.54)
        let pillar = Pillar(on : pillar1Location, isFinish : false)
        finishPillar = Pillar(on : finishPillarLocation, isFinish : true)
        
        rootNode.addChildNode(player)
        rootNode.addChildNode(gear)
        rootNode.addChildNode(halfGear)
        rootNode.addChildNode(pillar)
        rootNode.addChildNode(finishPillar)
        
        gears.removeAll()
        gears.append(gear)
        
        halfGear.isCounterRotate = true
        halfGears.removeAll()
        halfGears.append(halfGear)
    }
    
    
    
    func levelThreePanHandler(_ gestureRecognizer : UIPanGestureRecognizer){
        let location = gestureRecognizer.location(in: sceneView)
        let translation = gestureRecognizer.translation(in: sceneView)
        
        let hitResults = sceneView.hitTest(location, options: [:])
        
        if hitResults.count > 0 {
            let pannedPiece = hitResults.first?.node
            
            if pannedPiece == gears[0].childNodes.first {
                halfGearSystem(gear: gears[0], halfGear: halfGears[0], hitResult: hitResults.first!, translation: translation)
            }
        }
        
        if gestureRecognizer.state == .ended {
            for gear in gears{
                gear.isHaptic = true
                gear.isRotating = true
                gear.synchronize()
            }
            
            for halfGear in halfGears{
                halfGear.isRotateAble = true
                halfGear.synchronize()
            }
        }
    }
    
    func autoRotateSystemLevelThree(){
        gears[0].rotateGear(by : 0.2)
        halfGears[0].rotateGear(by: 0.2)
    }
}
