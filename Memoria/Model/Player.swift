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
    }
    
    func move(){
        playerNode.physicsBody!.velocity = velocity
    }
    
    func stop(){
        playerNode.physicsBody!.velocity = SCNVector3Zero
        movable = false
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
        let x = (destination.x - position.x) / distance
        let z = (destination.z - position.z) / distance
        let velocity = SCNVector3Make(x, 0, z)
        return velocity
    }
    
    func synchronize(){
        //        self.childNodes.first!.position = self.childNodes.first!.presentation.position
        //        self.position = self.childNodes.first!.position
        playerNode.position = playerNode.presentation.worldPosition
    }
}
