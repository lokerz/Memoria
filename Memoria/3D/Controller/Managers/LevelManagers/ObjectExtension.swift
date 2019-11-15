//
//  ObjectExtension.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 31/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit
import GameplayKit

extension LevelManager{
    
    func spawnPlayer(on position : SCNVector3){
        player = Player(on: position)
        rootNode.addChildNode(player)
    }
    
    func spawnPlayer(on position : SCNVector3, with velocity : Float){
        player = Player2(on: position)
        player.velocityFactor = velocity
        rootNode.addChildNode(player)
    }
    
    func spawnGear(on position : SCNVector3, with rotation : SCNVector4){
        let gear = GearPath(on: position, with: rotation)
        gear.setupPath()
        pathfinder.setupPath(nodes: gear.nodes, coordinates: gear.coordinates)
        rootNode.addChildNode(gear)
        gears.append(gear)
    }
    
    func spawnGear(on position : SCNVector3, with rotation : SCNVector4, counterRotate : Bool){
        let gear = GearPath(on: position, with: rotation)
        gear.isCounterRotate = counterRotate
        gear.setupPath()
        pathfinder.setupPath(nodes: gear.nodes, coordinates: gear.coordinates)
        rootNode.addChildNode(gear)
        gears.append(gear)
    }
    
    func spawnGear(on position : SCNVector3, with rotation : SCNVector4, minAngle: Float, maxAngle: Float){
        let gear = GearPath(on: position, with: rotation, minAngle: minAngle, maxAngle: maxAngle)
        gear.setupPath()
        pathfinder.setupPath(nodes: gear.nodes, coordinates: gear.coordinates)
        rootNode.addChildNode(gear)
        gears.append(gear)
    }
    
    func spawnHalfGear(on position : SCNVector3, with rotation : SCNVector4, minAngle : Float, maxAngle : Float, isCounterRotate : Bool){
        let gear = HalfGearPath(on: position, with: rotation, minAngle: minAngle, maxAngle: maxAngle)
        gear.isCounterRotate = isCounterRotate
        gear.setupPath()
        pathfinder.setupPath(nodes: gear.nodes, coordinates: gear.coordinates)
        rootNode.addChildNode(gear)
        halfGears.append(gear)
    }
    
    func spawnPillar(on position : SCNVector3){
        let pillar = PillarPath(on: position)
        pillar.setupPath()
        pathfinder.setupPath(nodes: pillar.nodes, coordinates: pillar.coordinates)
        rootNode.addChildNode(pillar)
        pillars.append(pillar)
    }
    
    func spawnPlatform(on position : SCNVector3, min : Float, max : Float){
        let platform = PlatformPath(on: position, minHeight: min, maxHeight: max)
        platform.setupPath()
        pathfinder.setupPath(nodes: platform.nodes, coordinates: platform.coordinates)
        rootNode.addChildNode(platform)
        platforms.append(platform)
    }
    
}
