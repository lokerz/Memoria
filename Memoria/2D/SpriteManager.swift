//
//  GameViewController.swift
//  Memoria
//
//  Created by Delvin on 21/10/19.
//  Copyright © 2019 Delvin. All rights reserved.
//


//usage
//let scene = SpriteManager.instance.callScene(index: 1)
//self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))

import UIKit
import SpriteKit

class SpriteManager {
    static var instance = SpriteManager()
    var sceneNumber = 0
    
    var sceneMain = "MainMenu"
    var sceneChapter = "ChapterSelect"
    
    var scenes = [
        "",
        "Prologue",
        "MobilScene",
        "PhotoScene",
        "PaperWork",
        "Office",
        "FrontHouse",
        "InHouse"
    ]
    
    func callScene(index : Int) -> SKScene{
        var scene = SKScene()
        switch index {
        case 1 : scene = Prologue(fileNamed: scenes[index])!
        case 2 : scene = MobilScene(fileNamed: scenes[index])!
        case 3 : scene = PhotoScene(fileNamed: scenes[index])!
        case 4 : scene = PaperWork(fileNamed: scenes[index])!
        case 5 : scene = Office(fileNamed: scenes[index])!
        case 6 : scene = FrontHouse(fileNamed: scenes[index])!
        case 7 : scene = InHouse(fileNamed: scenes[index])!
        case 99 : scene = ChapterSelect(fileNamed: sceneChapter)!
        default : scene = MainMenu(fileNamed: sceneMain)!
        }
        scene.scaleMode = .resizeFill
        
        return scene
    }
}
