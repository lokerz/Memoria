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
    
    func spawnPlayer(on position : SCNVector3, with velocity : Float){
        player = Player2(on: position)
        player.velocityFactor = velocity
        rootNode.addChildNode(player)
    }
    
    func spawnGear(on position : SCNVector3, with rotation : SCNVector4, index : Int){
        let gear = GearPath(on: position, with: rotation)
        gear.setupCoordinates()
        pathfinder.appendNode(nodes: gear.nodes, lastNode: gear.lastNode!, index: index)
        pathfinder.appendCoordinates(coordinates: gear.coordinates)
        rootNode.addChildNode(gear)
        gears.append(gear)
    }
    
    func spawnGear(on position : SCNVector3, with rotation : SCNVector4, counterRotate : Bool, index : Int){
        let gear = GearPath(on: position, with: rotation)
        gear.isCounterRotate = counterRotate
        gear.setupCoordinates()
        pathfinder.appendNode(nodes: gear.nodes, lastNode: gear.lastNode!, index: index)
        pathfinder.appendCoordinates(coordinates: gear.coordinates)
        rootNode.addChildNode(gear)
        gears.append(gear)
    }
    
    func spawnGear(on position : SCNVector3, with rotation : SCNVector4, minAngle: Float, maxAngle: Float, index : Int){
        let gear = GearPath(on: position, with: rotation, minAngle: minAngle, maxAngle: maxAngle)
        gear.setupCoordinates()
        pathfinder.appendNode(nodes: gear.nodes, lastNode: gear.lastNode!, index: index)
        pathfinder.appendCoordinates(coordinates: gear.coordinates)
        rootNode.addChildNode(gear)
        gears.append(gear)
    }
    
    func spawnHalfGear(on position : SCNVector3, with rotation : SCNVector4, minAngle : Float, maxAngle : Float, isCounterRotate : Bool, index : Int){
        let gear = HalfGear(on: position, with: rotation, minAngle: minAngle, maxAngle: maxAngle)
        gear.isCounterRotate = isCounterRotate
//
//        gear.setupCoordinates()
//        pathfinder.appendNode(nodes: gear.nodes, lastNode: gear.lastNode!, index: index)
//        pathfinder.appendCoordinates(coordinates: gear.coordinates)
//
        rootNode.addChildNode(gear)
        halfGears.append(gear)
    }
    
    func spawnPillar(on position : SCNVector3, index : Int){
        let pillar = PillarPath(on: position)
        pillar.setupCoordinates()
        pathfinder.appendNode(nodes: pillar.nodes, lastNode: pillar.lastNode!, index: index)
        pathfinder.appendCoordinates(coordinates: pillar.coordinates)
        rootNode.addChildNode(pillar)
        pillars.append(pillar)
    }
    
    func spawnPlatform(on position : SCNVector3, min : Float, max : Float, index : Int){
        let platform = Platform(on: position, minHeight: min, maxHeight: max)
        rootNode.addChildNode(platform)
        platforms.append(platform)
    }
    
    func spawnFinishPoint(on position : SCNVector3){
        
    }
    
}
