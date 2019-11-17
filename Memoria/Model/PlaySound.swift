//
//  PlaySound.swift
//  Memoria
//
//  Created by Delvin on 17/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//


//usage
//run(PlaySound.instance.playSound(index: 1))

import SpriteKit

class PlaySound{
    static var instance = PlaySound()
    var sound = [
    "",
    "Lulu_Is_the_Cat_I_Like_Best.mp3"
    ]
    
    func playSound(index: Int) -> SKAction{
        var sounds = SKAction()
        switch index {
        case 1 : sounds = SKAction.playSoundFileNamed(sound[index], waitForCompletion: false)
        default : print("")
        }
        return sounds
    }
}
