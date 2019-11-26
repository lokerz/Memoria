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
    
    var isChangingToSceneKit = false
    var gameLevel = 0
    
    var skView = SKView()
    var skDelegate : SKSceneDelegate?
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
    
    func setupView(view : SKView){
        skView = view
        skView.ignoresSiblingOrder = true
        
//        view.showsFPS = true
//        view.showsNodeCount = true
    }
    
    func setupDelegate(delegate : SKSceneDelegate){
        skDelegate = delegate
    }
    
    func loadScene(_ index: Int) -> SKScene{
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
        scene.delegate = skDelegate
        return scene
    }
    
    func callScene(index : Int){
        skView.presentScene(loadScene(index))
    }
    
    func callScene(index : Int, transition : SKTransition){
        skView.presentScene(loadScene(index), transition: SKTransition.fade(withDuration: 1))
    }
    
    func loadGame(level : Int){
        gameLevel = level
        isChangingToSceneKit = true
    }
}
