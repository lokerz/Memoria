//
//  Level1Extension.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 22/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class LevelOneManager : LevelManager{
    
    let playerPosition = SCNVector3Make(-6.06, 7.77, 0)
    
    let pillarRotation = SCNVector4Make(0, 1 , 0, GLKMathDegreesToRadians(-90))
    let pillarPosition = SCNVector3Make(-6.06, 4.60, 0)
    let finishPillarRotation = SCNVector4Make(0, 1 , 0, GLKMathDegreesToRadians(90))
    let finishPillarPosition = SCNVector3Make(5.74, -0.42, 0)
    
    let gearOnePosition = SCNVector3Make(-2.71, 0, 0)
    let gearOneRotation = SCNVector4Make(0, 0, 0, 0)
    
    let gearTwoPosition = SCNVector3Make(2.34, 0, 0)
    let gearTwoRotation = SCNVector4Make(0, 1, 0, GLKMathDegreesToRadians(10))
    let gearTwoCounterRotate = true
    
    
    override func setupLevel(){
        super.setupLevel()
        
        //        spawnPlayer(on: playerPosition)
        spawnPlayer(on: playerPosition, with: playerVelocity)
        spawnPillar(on: pillarPosition, with: pillarRotation)
        spawnGear(on: gearOnePosition, with: gearOneRotation)
        spawnGear(on: gearTwoPosition, with: gearTwoRotation, counterRotate : gearTwoCounterRotate)
        spawnPillar(on: finishPillarPosition, with: finishPillarRotation)
        let finishPosition = SCNVector3Make(finishPillarPosition.x, 0, finishPillarPosition.z)
        player.finishLocation = finishPosition
        //        player.pathManager = LevelOnePathfindingManager()
        pillars.first!.moveDown(by: 5, duration: 3)
        
        pathfinder.setupNodes()
        
    }
    
    @objc override func handlePan(_ gestureRecognizer : UIPanGestureRecognizer){
        super.handlePan(gestureRecognizer)
        
        if hitResults.count > 0 {
            if let pannedPiece = hitResults.first?.node{
                print(pannedPiece.name)
                if hitResults.first!.worldCoordinates.z > 0 {
                    if gears[0].childNodes.contains(pannedPiece){
                        gearSystem(gearA: gears[0], gearB: gears[1], relation: .oppositeDirection, hitResult: hitResults.first!, translation: translation)
                    }
                    else if gears[1].childNodes.contains(pannedPiece){
                        gearSystem(gearA: gears[1], gearB: gears[0], relation: .oppositeDirection, hitResult: hitResults.first!, translation: translation)
                    }
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


