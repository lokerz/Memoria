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
    case soundEffect2D
}

class FirstPlayer{
    static var instance = FirstPlayer()
    
    var player: AVAudioPlayer?
    var volume : Float = 1
    var mainTheme = [
    "",
    "BGM Elio 2.0",
    "Piano In Blue",
    "PianoDreams",
    "full_ThisBeautifulWorld",
    "mainfile_sweet-love-piano"
    ]
    
    var soundChapter1 = [
    "",
    "Adoption letter",
    "Drop",
    "Open Door",
    "OldPhoto",
    "Write",
    "Car Ambience",
    "Road",
    "Clock",
    "Night Ambience"
    ]
    
    var chapterSelect = [
    "",
    "Book_Flip",
    "PlayClick"
    ]
    
    var soundEffect2D = [
    "",
    "menubutton",
    "skipbutton",
    "NextButton"
    ]
    
    func playSound(for part : part, index: Int) {
        var resource = ""
        switch part {
        case .chapter1 : resource = soundChapter1[index]
        case .chapterSelect : resource = chapterSelect[index]
        case .soundEffect2D : resource = soundEffect2D[index]
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
            player.volume = volume
            player.stop()
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

class BGMPlayer{
    static var instance = BGMPlayer()
    
    var player: AVAudioPlayer?
    
    func playSound(for part : part, index: Int, volume: Float) {
        var resource = ""
        switch part {
        case .chapter1 : resource = FirstPlayer.instance.soundChapter1[index]
        case .chapterSelect : resource = FirstPlayer.instance.chapterSelect[index]
        default : resource = FirstPlayer.instance.mainTheme[index]
        }
        
        guard let url = Bundle.main.url(forResource: resource, withExtension: "mp3") else { return }
        play(url: url, volume: volume)
    }
    
    func play(url : URL, volume: Float){
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            
            guard let player = player else { return }
            player.volume = volume
            player.stop()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
