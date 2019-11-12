//
//  Player2.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 05/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Player2 : Player {
    var path = [SCNVector3]()
    var lastDestination = SCNVector3()
    var pathIndex = 0
    var isLastDestination = false
    
    override func movePlayer(hitTestResult : SCNHitTestResult){
        playerNode.physicsBody!.isAffectedByGravity = false
        pathIndex = 0
        synchronize()
        lastHeight = Int(roundf(playerNode.position.y * 10))
        
        if !isFinished {
            isMovable = true
            lastDestination = SCNVector3Make(hitTestResult.worldCoordinates.x, 0 , hitTestResult.worldCoordinates.z)
            isLastDestination = false
            HapticGenerator.instance.play(5)
            path = nearestNode(to: lastDestination)
            if path.count != 0 {
                destination = path[pathIndex]
                print(path, destination)
                velocity = calculateVelocity(to: destination)
                move()
            }
        }
    }
    
    func nearestNode(to destination : SCNVector3) -> [SCNVector3]{
        synchronize()
        let position = playerNode.position
        return pathManager.calculateNode(from: position, to: destination)
    }
    
    override func checkPosition(){
        
        if isMovable {
            if checkLastPos(){
                stop()
            }else if checkNextDestination(){
                nextDestination()
            } else {
                move()
            }
        }
        if playerNode.position.y < -5 {
            stop()
            reset()
        }
        checkFinished()
    }
    
    func checkLastPos() -> Bool{
        let worldPos = playerNode.presentation.worldPosition
        let position = SCNVector3Make(worldPos.x, 0, worldPos.z)
        return calculateDistance(from: position, to: lastDestination) < playerNode.scale.x * playerRadius
    }
    
    func checkNextDestination() -> Bool {
        let worldPos = playerNode.presentation.worldPosition
        let position = SCNVector3Make(worldPos.x, 0, worldPos.z)
        return calculateDistance(from: position, to: destination) < playerNode.scale.x * playerRadius  && !isLastDestination
    }
    
    func nextDestination(){
        print(#function, pathIndex, path.count)

        if pathIndex < path.count - 1{
            pathIndex += 1
            destination = path[pathIndex]
            velocity = calculateVelocity(to: destination)
        } else {
            isLastDestination = true
            velocity = calculateVelocity(to: lastDestination)
        }
        isMovable = true
    }
}
