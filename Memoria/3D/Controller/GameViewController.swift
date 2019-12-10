//
//  GameViewController.swift
//  SCNTest
//
//  Created by Ridwan Abdurrasyid on 16/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
    var sceneView : SCNView!
    var scene : SCNScene!
    
    var level = 0
    var finishLevel = 2
    
    var levelManager = LevelManager()
    var gestureManager = GestureManager.instance
    var delegate : TransitionDelegate?
    var isLoading = false
    var isActive = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWorld()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setup(level : Int){
        self.level = level
        setupLevelManager(level : level)
        setupGesture()
        startGame()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if isActive{
            if levelManager.player.isFinished && !isLoading{
                endLevel()
            }
            
            levelManager.checkPlayer()
            
            if !levelManager.isStarting{
                levelManager.autoRotateSystem()
            }
        }
    }
    
    func setupWorld(){
        sceneView = SCNView()
        sceneView.frame = view.frame
        scene = SCNScene(named: "art.scnassets/World.scn")
        sceneView.scene = scene
        sceneView.delegate = self
        sceneView.backgroundColor = .white
//        sceneView.isJitteringEnabled = true
        sceneView.antialiasingMode = .multisampling4X
        view.addSubview(sceneView)
        
//        if let path = Bundle.main.path(forResource: "NodeTechnique", ofType: "plist") {
//            if let dict = NSDictionary(contentsOfFile: path)  {
//                let dict2 = dict as! [String : AnyObject]
//                let technique = SCNTechnique(dictionary:dict2)
//                sceneView.technique = technique
//            }
//        }
//                sceneView.showsStatistics = true
//                sceneView.debugOptions = [.showPhysicsShapes, .showWireframe]
    }
    
    func setupLevelManager(level : Int){
        switch level {
        case 1 : levelManager = LevelOneManager()
        case 3 : levelManager = LevelTwoManager()
        case 2 : levelManager = LevelThreeManager()
        default : levelManager = LevelManager()
        }
        levelManager.sceneView = sceneView
    }
    
    func setupGesture(){
        gestureManager.setupGesture(sceneView, levelManager)
    }
    
    func startGame(){
        levelManager.setupLevel()
        levelManager.player.isFinished = false
    }
    
    func endLevel(){
        isLoading = true
        levelManager.endLevel()
        gestureManager.removeGesture(sceneView)
        
        let _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (Timer) in
            if self.level == self.finishLevel {
                self.delegate?.showSpriteKit?(index: 8, transition: .fade(withDuration: 1))
            }
            else {
                self.level += 1
                self.setup(level: self.level)
                self.isLoading = false
            }
        }
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
