//
//  Player2.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 05/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Player3 : Player {
    var path = [SCNVector3]()
    var lastDestination = SCNVector3()
    var pathIndex = 1
    var isLastDestination = false
    var isMoving = false
    
    var pointOfViewNode = SCNNode()
    
    override func movePlayer(hitTestResult : SCNHitTestResult){
        isMovable = false
        pathIndex = 1
        synchronize()
        
        if !isFinished {
            HapticGenerator.instance.play(5)
            lastDestination = SCNVector3Make(hitTestResult.worldCoordinates.x, 0 , hitTestResult.worldCoordinates.z)
            //            isLastDestination = false
            path = nearestNode(to: lastDestination)
            lastDestination = path.last!
            if path.count > 1 {
                isMovable = true
                destination = path[pathIndex]
                move(to: destination)
                startAnimation(for: "run")
            }
        }
    }
    
    override func checkPosition(){
        //        print(isMoving)
        //        print(playerNode.position.y, height)
        
        if isMovable {
            if checkNextDestination(){
                nextDestination()
            }
            if isMoving {
                playerNode.look(at: pointOfViewNode.position)
            }
        }
        checkFinished()
    }
    
    func move(to destination : SCNVector3){
        synchronize()
        let coordinate = SCNVector3Make(destination.x, playerNode.position.y, destination.z)
        let distance = calculateDistance(from: playerNode.position, to: coordinate)
        let duration = calculateTime(velocity: velocityFactor, distance: distance)
        let move = SCNAction.move(to: coordinate, duration: duration)
        playerNode.runAction(move)
        rotate(to: coordinate, with: duration/3)
    }
    
    func rotate(to direction : SCNVector3, with duration : Double){
        if !isMoving {
            pointOfViewNode.position = direction
            isMoving = true
        }else{
            let move = SCNAction.move(to: direction, duration: duration).easeInOut()
            pointOfViewNode.runAction(move)
        }
    }
    
    override func stop(){
        super.stop()
        playerNode.removeAllActions()
    }
    
    func nearestNode(to destination : SCNVector3) -> [SCNVector3]{
        synchronize()
        let position = playerNode.position
        return pathManager.calculateNode(from: position, to: destination)
    }
    
    func checkNextDestination() -> Bool {
        let worldPos = playerNode.presentation.worldPosition
        let position = SCNVector3Make(worldPos.x, 0, worldPos.z)
        return calculateDistance(from: position, to: destination) < playerNode.scale.x * playerRadius  && !isLastDestination
    }
    
    func nextDestination(){
        if pathIndex < path.count - 1{
            pathIndex += 1
            destination = path[pathIndex]
            move(to: destination)
            isMovable = true
        } else {
            stop()
        }
    }
    
    override func setupPointOfView(){
        self.addChildNode(pointOfViewNode)
        let geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.1)
        pointOfViewNode.geometry = geometry
        pointOfViewNode.isHidden = true
    }
}
