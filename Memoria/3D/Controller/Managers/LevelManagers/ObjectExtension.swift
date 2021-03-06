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
        player = Player3(on: position)
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
    
    func spawnPillar(on position : SCNVector3, with rotation : SCNVector4){
        let pillar = PillarPath(on: position, with : rotation)
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
    
    func spawnPathnodes(){
        for coordinate in pathfinder.coordinates {
            let node = SCNNode()
            node.geometry = SCNBox(width: 0.2, height: 0.5, length: 0.2, chamferRadius: 0.2)
            node.position = SCNVector3Make(coordinate.x, 0.25, coordinate.z)
            rootNode.addChildNode(node)
        }
    }
    
    func spawnCloud(){
        let cloud = Cloud()
        rootNode.addChildNode(cloud)
    }
    
    func spawnArrow(on position:  SCNVector3, with rotation : SCNVector4, delay : Double, animation : arrowAnimation){
        let arrow = Arrow(on : position, with : rotation, delay : delay)
        switch animation {
            case .tap : arrow.tapAnimation()
            case .pan : arrow.panAnimation()
            case .none : break
        }
        rootNode.addChildNode(arrow)
        hints.append(arrow)
    }
}

