//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Player : SCNNode{
    var movable = false
    var destination = SCNVector3()
    var playerNode = SCNNode()
    var velocity = SCNVector3()
    var velocityFactor : Float = 1
    var beginningPosition =  SCNVector3()
    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3){
        super.init()
        guard let object = SCNScene(named: "art.scnassets/player.scn") else { return }
        for node in object.rootNode.childNodes{
            self.addChildNode(node)
        }
        playerNode = self.childNodes.first!
        beginningPosition = position
        playerNode.position = position
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func checkPosition(){
        if movable {
            if calculateDistance() < playerNode.scale.x * 1.5  {
                stop()
            } else {
                move()
            }
        }
        if playerNode.position.y < 0 {
            stop()
        }
        if playerNode.position.y < -5 {
            reset()
        }
    }
    
    func move(){
        playerNode.physicsBody!.velocity = velocity
        synchronize()
    }
    
    func stop(){
        movable = false
        playerNode.physicsBody!.velocity = SCNVector3Zero 
        synchronize()
    }
    
    func reset(){
        playerNode.position = beginningPosition
    }
    
    func movePlayer(hitTestResult : SCNHitTestResult){
        HapticGenerator().play(5)
        destination = hitTestResult.worldCoordinates
        velocity = calculateVelocity()
        movable = true
        
        synchronize()
        move()
    }
    
    func calculateDistance()  -> Float{
        let node1Pos = SCNVector3ToGLKVector3(playerNode.presentation.worldPosition)
        let node2Pos = SCNVector3ToGLKVector3(destination)
        let distance = GLKVector3Distance(node1Pos, node2Pos)
        return distance
    }
    
    func calculateVelocity() -> SCNVector3{
        let distance = calculateDistance()
        let position = playerNode.presentation.worldPosition
        let x = (destination.x - position.x) / distance * velocityFactor
        let y = playerNode.physicsBody!.velocity.y
        let z = (destination.z - position.z) / distance * velocityFactor
        let velocity = SCNVector3Make(x, y, z)
        return velocity
    }
    
    func synchronize(){
        //        self.childNodes.first!.position = self.childNodes.first!.presentation.position
        //        self.position = self.childNodes.first!.position
        playerNode.position = playerNode.presentation.worldPosition
    }
}
