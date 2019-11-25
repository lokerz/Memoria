//
//  Level1Extension.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 22/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class LevelThreeManager : LevelManager {
    
    
    let playerPosition = SCNVector3Make(-6.68, 7.5, 0)
    
    let pillarPosition = SCNVector3Make(-6.68, 4.465, 0)
    let finishPillarPosition = SCNVector3Make(4.29, -0.56, 0)
    
    let gearOnePosition = SCNVector3Make(-2.78, 0, 0)
    let gearOneRotation = SCNVector4Make(0, 0, 0, 0)
    
    let gearTwoPosition = SCNVector3Make(2.34, 0, 0)
    let gearTwoRotation = SCNVector4Make(0, 0, 0, 0.528)
    
    
    
    override func setupLevel(){
        super.setupLevel()
        spawnPlayer(on: playerPosition, with: playerVelocity)
        spawnPillar(on: pillarPosition)
        spawnGear(on: gearOnePosition, with: gearOneRotation, minAngle: -0.02, maxAngle: 1.13)
        spawnHalfGear(on: gearTwoPosition, with: gearTwoRotation, minAngle: -0.61, maxAngle: 0.54, isCounterRotate : true)
        spawnPillar(on: finishPillarPosition)
        let finishPosition = SCNVector3Make(finishPillarPosition.x, 0, finishPillarPosition.z)
        player.finishLocation = finishPosition
        
        pillars.first!.moveDown(by: 5, duration: 3)
        
        pathfinder.setupNodes()
    }
    
    
    
    @objc override func handlePan(_ gestureRecognizer : UIPanGestureRecognizer){
        super.handlePan(gestureRecognizer)
        
        if hitResults.count > 0 {
            let pannedPiece = hitResults.first?.node
            
            if hitResults.first!.worldCoordinates.z > 0 {
                if pannedPiece == gears[0].childNodes.first {
                    halfGearSystem(gear: gears[0], halfGear: halfGears[0], hitResult: hitResults.first!, translation: translation)
                }
            }
        }
        
        if gestureRecognizer.state == .ended {
            for gear in gears{
                gear.isHaptic = true
                gear.isRotating = true
                gear.synchronize()
            }
            
            for halfGear in halfGears{
                halfGear.synchronize()
            }
        }
    }
    
    override func autoRotateSystem(){
        super.autoRotateSystem()
        halfGears[0].rotateGear(by: 0.2)
    }
}
