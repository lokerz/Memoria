//
//  PlaySound.swift
//  Memoria
//
//  Created by Delvin on 17/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//


//usage
//run(PlaySound.instance.playSoundEffect(index: 1))

import AVFoundation

class PlaySound{
    static var instance = PlaySound()
    
    var player: AVAudioPlayer?
    
    var mainTheme = [
    ""
    ]
    
    var soundChapter1 = [
    "",
    "Lulu_Is_the_Cat_I_Like_Best"
    ]
    
    func playSoundSEChapter1(index: Int) {
        guard let url = Bundle.main.url(forResource: soundChapter1[index], withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playBGM(index: Int) {
        guard let url = Bundle.main.url(forResource: mainTheme[index], withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
