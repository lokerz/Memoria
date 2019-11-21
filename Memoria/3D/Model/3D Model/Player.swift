//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Player : SCNNode{
    var isMovable = false
    var isFinished = false
    var isFalling = false
    
    var destination = SCNVector3()
    var playerNode = SCNNode()
    var velocity = SCNVector3()
    var scaleFactor : Float = 0.5
    var velocityFactor : Float = 0.5
    var playerRadius : Float = 1.25
    var beginningPosition =  SCNVector3()
    var finishLocation = SCNVector3()
    var lastHeight : Int = 0
    
    var pathManager = PathfindingManager.instance

    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3){
        super.init()
        guard let object = SCNScene(named: "art.scnassets/player2.scn") else { return }
        for node in object.rootNode.childNodes{
            self.addChildNode(node)
        }
        self.name = "Player"
        playerNode = self.childNodes.first!
        beginningPosition = position
        playerNode.position = position
        lastHeight = Int(roundf(playerNode.position.y * 10))
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func movePlayer(hitTestResult : SCNHitTestResult){
        synchronize()
        lastHeight = Int(roundf(playerNode.position.y * 10))
        
        if !isFinished {
            isMovable = true
            HapticGenerator.instance.play(5)
            destination = hitTestResult.worldCoordinates
            velocity = calculateVelocity(to: destination)

            move()
        }
    }
    
    func checkPosition(){
        let position = playerNode.presentation.worldPosition
        if isMovable {
            if calculateDistance(from: position, to: destination) < playerNode.scale.x * playerRadius  {
                stop()
            } else {
                move()
            }
        }
        if playerNode.position.y < -5 {
            stop()
            reset()
        }
        if checkHeight(){
            fall()
        }
        checkFinished()
    }
    
    func checkFinished(){
        let position = SCNVector3Make(playerNode.presentation.worldPosition.x, 0, playerNode.presentation.worldPosition.z)
        //        print(calculateDistance(nodeA: position, nodeB: finishLocation))
        if calculateDistance(from: position, to: finishLocation) < 0.8 {
            isFinished = true
        }
        else {
            isFinished = false
        }
    }
    
    func checkHeight() -> Bool{
        let presentHeight = Int(roundf(playerNode.position.y * 10))
        return presentHeight < lastHeight
    }
    
    func move(){
        synchronize()
        playerNode.physicsBody!.velocity = velocity
    }
    
    func stop(){
        synchronize()
        isMovable = false
        playerNode.physicsBody!.velocity = SCNVector3Zero
        playerNode.physicsBody?.angularVelocity = SCNVector4Make(0, 1, 0, 0)
    }
    
    func fall(){
        synchronize()
        isMovable = false
        let y = playerNode.physicsBody!.velocity.y
        if !isFalling {
            isFalling = true
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (Timer) in
                self.playerNode.physicsBody!.velocity = SCNVector3Make(0, y, 0)
                self.isFalling = false
            }
        }
    }
    
    func reset(){
        playerNode.position = beginningPosition
    }
    
    
    func calculateDistance(from nodeA: SCNVector3, to nodeB: SCNVector3)  -> Float{
        let node1Pos = SCNVector3ToGLKVector3(nodeA)
        let node2Pos = SCNVector3ToGLKVector3(nodeB)
        let distance = GLKVector3Distance(node1Pos, node2Pos)
        return distance
    }
    
    func calculateVelocity(to destination : SCNVector3) -> SCNVector3{
        let position = playerNode.presentation.worldPosition
        let distance = calculateDistance(from: position, to: destination)
        let x = (destination.x - position.x) / distance * velocityFactor
        let y : Float = 0
        let z = (destination.z - position.z) / distance * velocityFactor
        let velocity = SCNVector3Make(x, y, z)
        return velocity
    }
    
    func synchronize(){
        playerNode.position = playerNode.presentation.worldPosition
    }
}
