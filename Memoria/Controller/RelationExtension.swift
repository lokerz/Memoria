//
//  Level1Extension.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 22/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

enum relation {
    case sameDirection
    case oppositeDirection
    case nonInfluence
}

extension GameViewController {
    
    func autoRotateSystem(level : Int){
        if !isPanning {
            switch level {
            case 1 : autoRotateSystemLevelOne()
            case 3 : autoRotateSystemLevelTwo()
            default : autoRotateSystemLevelThree()
            }
        }
    }
    
    func gearSystem(gearA : Gear, gearB : Gear, relation : relation, hitResult : SCNHitTestResult, translation : CGPoint){
        gearB.isHaptic = !gearA.isHaptic
        gearB.isRotating = false
        
        let negativeTranslation = CGPoint(x: -translation.x, y: translation.y)
        
        if gearA.isRotating && !gearB.isRotating{
            gearA.rotateGear(from : hitResult, by: translation)
            switch relation {
            case .oppositeDirection : gearB.rotateGear(from: hitResult, by: negativeTranslation)
            case .sameDirection : gearB.rotateGear(from: hitResult, by: translation)
            default : break
            }
        }
    }
    
    func halfGearSystem(gear : Gear, halfGear : HalfGear, hitResult : SCNHitTestResult, translation : CGPoint){
        halfGear.isHaptic = false
        let negativeTranslation = CGPoint(x: -translation.x, y: translation.y)
        
        if halfGear.isRotateAble{
            halfGear.rotateGear(from: hitResult, by: negativeTranslation)
            gear.rotateGear(from : hitResult, by: translation)
        }
    }
    
    func platformSystem(gear : Gear, platform : Platform, relation : relation, hitResult : SCNHitTestResult, translation : CGPoint){
        
        let negativeTranslation = CGPoint(x: -translation.x, y: translation.y)
        
        gear.rotateGear(from : hitResult, by: translation)
        if hitResult.worldCoordinates.z > 0 {
            switch relation {
            case .oppositeDirection : platform.move(by : negativeTranslation)
            case .sameDirection : platform.move(by: translation)
            default : break
            }
        }
    }
    
    
}
