//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Player : SCNNode, CAAnimationDelegate{
    var scaleMultiplier = 1
    var velocity : Float = 5
    var movable = true
    var timer = Timer()
    var destination = SCNVector3()
    
    override init() {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/player.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.scale = SCNVector3(scaleMultiplier, scaleMultiplier, scaleMultiplier)
        let body = SCNPhysicsBody(type: .dynamic, shape: nil)
        body.isAffectedByGravity = false
        self.physicsBody = body
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stop(){
        self.physicsBody?.velocity = SCNVector3Zero
        self.position = self.presentation.worldPosition
    }
    
    func movePlayer2(hitTestResult : SCNHitTestResult){
        HapticGenerator().play(5)
        stop()
        timer.invalidate()
        velocity = velocity / 10
        destination = SCNVector3(hitTestResult.worldCoordinates.x, self.position.y, hitTestResult.worldCoordinates.z)
        let duration = calculateTime(to: destination)
        let direction = calculateDirection(to: destination)
        self.physicsBody?.velocity = SCNVector3Make(direction.x  * velocity, direction.y * velocity, direction.z * velocity)
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(duration), repeats: false) { (Timer) in
//            self.stop()
        }
    }
    
    func movePlayer(hitTestResult : SCNHitTestResult){
        if movable {
            HapticGenerator().play(5)
            movable = false
            destination = SCNVector3(hitTestResult.worldCoordinates.x, self.position.y, hitTestResult.worldCoordinates.z)
            animateMove(to: destination)
            self.position = destination
        }
    }
    
    func animateMove(to destination : SCNVector3){
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = self.position
        animation.toValue = destination
        animation.duration = Double(calculateTime(to : destination))
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.addAnimation(animation, forKey: "position")
        
        animation.setValue("position", forKey: "animationID")
        animation.delegate = self
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animationID = anim.value(forKey: "animationID") {
            if animationID as! NSString == "position" {
                movable = true
            }
        }
    }
    
    func calculateDistance(to destination : SCNVector3)  -> Float{
        let node1Pos = SCNVector3ToGLKVector3(self.position)
        let node2Pos = SCNVector3ToGLKVector3(destination)
        let distance = GLKVector3Distance(node1Pos, node2Pos)
        return distance
    }
    
    func calculateTime(to destination : SCNVector3) -> Float{
        let distance = calculateDistance(to: destination)
        let duration = distance / velocity
        return duration
    }
    
    func calculateDirection(to destination : SCNVector3) -> SCNVector3{
        let distance = calculateDistance(to: destination)
        let direction = SCNVector3Make(destination.x/distance, destination.y/distance, destination.z/distance)
        return direction
    }
}
