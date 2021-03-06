//
//  Level1Extension.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 22/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class LevelTwoManager : LevelManager {
    let playerPosition = SCNVector3Make(-7.6, 0.1, 0)
    
    let platformPosition = SCNVector3Make(0, -0.5, 0)
    
    let gearOnePosition = SCNVector3Make(-3.7, 0, 0)
    let gearOneRotation = SCNVector4Make(0, 0, 0, 0)
    
    let gearTwoPosition = SCNVector3Make(3.7, 0, 0)
    let gearTwoRotation = SCNVector4Make(0, 0, 0, 0)
    let gearTwoCounterRotate = true
    
    let pillarPosition = SCNVector3Make(-7.6, -0.56, 0)
    let finishPillarPosition = SCNVector3Make(7.6, -0.56, 0)
    
    
    override func setupLevel(){
        super.setupLevel()
        spawnPlayer(on: playerPosition,with: playerVelocity)
        spawnPillar(on: pillarPosition)
        spawnGear(on: gearOnePosition, with: gearOneRotation)
        spawnPlatform(on: platformPosition, min: -0.5, max: 1)
        spawnGear(on: gearTwoPosition, with: gearTwoRotation, counterRotate : gearTwoCounterRotate)
        spawnPillar(on: finishPillarPosition)
        
        let finishPosition = SCNVector3Make(finishPillarPosition.x, 0, finishPillarPosition.z)
        player.finishLocation = finishPosition
        
        pillars.first!.moveDown(by: 5, duration: 3)
        platforms.first?.moveDown(by: -1.5, duration: 3)
        
        pathfinder.setupNodes()
    }
    
    
    
    @objc override func handlePan(_ gestureRecognizer : UIPanGestureRecognizer){
        super.handlePan(gestureRecognizer)
        
        if hitResults.count > 0 {
            let pannedPiece = hitResults.first?.node
            if hitResults.first!.worldCoordinates.z > 0 {
                if pannedPiece == gears[0].childNodes.first {
                    gearSystem(gearA: gears[0], gearB: gears[1], relation: .nonInfluence, hitResult: hitResults.first!, translation: translation)
                    platformSystem(gear : gears[0], platform: platforms[0], relation: .sameDirection, hitResult : hitResults.first!, translation : translation)
                }
                else if pannedPiece == gears[1].childNodes.first {
                    gearSystem(gearA: gears[1], gearB: gears[0], relation: .nonInfluence, hitResult: hitResults.first!, translation: translation)
                    platformSystem(gear : gears[1], platform: platforms[0], relation: .oppositeDirection, hitResult : hitResults.first!, translation : translation)
                }
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
