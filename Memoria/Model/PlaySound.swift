//
//  PlaySound.swift
//  Memoria
//
//  Created by Delvin on 17/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//


//usage
//PlaySound.instance.playSEChapter1(index: 1)

import AVFoundation

enum part {
    case mainMenu
    case chapterSelect
    case chapter1
    case chapter2
    case chapter3
    case chapter4
    case chapter5
    case BGM3D
    case soundEffect3D
}
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
    
    func playSound(for part : part, index: Int) {
        var resource = ""
        switch part {
            case .chapter1 : resource = soundChapter1[index]
            default : resource = mainTheme[index]
        }
        
        guard let url = Bundle.main.url(forResource: resource, withExtension: "mp3") else { return }
        play(url: url)
    }
    
    func play(url : URL){
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
