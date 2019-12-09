//
//  PlayerAnimation.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 09/12/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

extension Player {
    func loadAnimations(){
        let fps : Double = 60
        let playerAnimation = SCNAnimation(named: "art.scnassets/playerAnimation.scnanim")
        
        let idleAnimation = playerAnimation.copy() as! SCNAnimation
        idleAnimation.repeatCount = .greatestFiniteMagnitude
        idleAnimation.blendInDuration = 0.3
        idleAnimation.blendOutDuration = 0.3
        idleAnimation.duration = 150/fps
        let idlePlayer = SCNAnimationPlayer(animation: idleAnimation)
        playerNode.addAnimationPlayer(idlePlayer, forKey: "idle")
        
        let temp = CAAnimation(scnAnimation: playerAnimation)
        temp.timeOffset = 160/fps
        let animation = CAAnimationGroup()
        animation.animations = [temp]
        animation.duration = (207 - 160)/fps
        let runAnimation = SCNAnimation(caAnimation: animation)
        runAnimation.repeatCount = .greatestFiniteMagnitude
        runAnimation.blendInDuration = 0.3
        runAnimation.blendOutDuration = 0.3
        print(runAnimation.timeOffset, runAnimation.duration)
        let runPlayer = SCNAnimationPlayer(animation: runAnimation)
        playerNode.addAnimationPlayer(runPlayer, forKey: "run")
    }
    
    func startAnimation(for identifier : String){
        playerNode.animationPlayer(forKey: identifier)!.play()
    }
    
    func stopAnimation(for identifier : String){
        playerNode.animationPlayer(forKey: identifier)!.stop(withBlendOutDuration: 0.3)
    }
}
