//
//  ObjectExtension.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 31/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

extension LevelManager{
    func spawnPlayer(on position : SCNVector3){
        player = Player(on: position)
        rootNode.addChildNode(player)
    }
    
    func spawnPlayer2(on position : SCNVector3){
        player = Player2(on: position)
        rootNode.addChildNode(player)
    }
    
    func spawnGear(on position : SCNVector3, with rotation : SCNVector4){
        let gear = Gear(on: position, with: rotation)
        rootNode.addChildNode(gear)
        gears.append(gear)
    }
    
    func spawnGear(on position : SCNVector3, with rotation : SCNVector4, counterRotate : Bool){
        let gear = Gear(on: position, with: rotation)
        gear.isCounterRotate = counterRotate
        rootNode.addChildNode(gear)
        gears.append(gear)
    }
    
    func spawnGear(on position : SCNVector3, with rotation : SCNVector4, minAngle: Float, maxAngle: Float){
        let gear = Gear(on: position, with: rotation, minAngle: minAngle, maxAngle: maxAngle)
        rootNode.addChildNode(gear)
        gears.append(gear)
    }
    
    func spawnHalfGear(on position : SCNVector3, with rotation : SCNVector4, minAngle : Float, maxAngle : Float, isCounterRotate : Bool){
        let gear = HalfGear(on: position, with: rotation, minAngle: minAngle, maxAngle: maxAngle)
        gear.isCounterRotate = isCounterRotate
        rootNode.addChildNode(gear)
        halfGears.append(gear)
    }
    
    func spawnPillar(on position : SCNVector3){
        let pillar = Pillar(on: position)
        rootNode.addChildNode(pillar)
        pillars.append(pillar)
    }
    
    func spawnPlatform(on position : SCNVector3, min : Float, max : Float){
        let platform = Platform(on: position, minHeight: min, maxHeight: max)
        rootNode.addChildNode(platform)
        platforms.append(platform)
    }
    
    func spawnFinishPoint(on position : SCNVector3){
        
    }
    
}
