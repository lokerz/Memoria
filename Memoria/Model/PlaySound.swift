//
//  PlaySound.swift
//  Memoria
//
//  Created by Delvin on 17/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//


//usage
//run(PlaySound.instance.playSoundEffect(index: 1))

import SpriteKit

class PlaySound{
    static var instance = PlaySound()
    
    var mainTheme = [
    ""
    ]
    
    var soundChapter1 = [
    "",
    "Lulu_Is_the_Cat_I_Like_Best.mp3"
    ]
    
    func playSoundEffectChapter1(index: Int) -> SKAction{
        var sounds = SKAction()
        sounds = SKAction.playSoundFileNamed(soundChapter1[index], waitForCompletion: false)
        return sounds
    }
    
    func playBackgroundMusic(index: Int) -> SKAction{
        var sounds = SKAction()
        sounds = SKAction.playSoundFileNamed(mainTheme[index], waitForCompletion: false)
        return sounds
    }
    
}
