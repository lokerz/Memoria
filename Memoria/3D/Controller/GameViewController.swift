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
    var level = 1
    
    var sceneView : SCNView!
    var scene : SCNScene!
    
    var levelManager = LevelManager()
    var gestureManager = GestureManager.instance
    var isLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWorld()
        setupUI()
        setupLevelManager()
        setupGesture()
        startGame()
        
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        levelManager.checkPlayer()
        if !levelManager.isPanning{
            levelManager.autoRotateSystem()
        }
        
        if levelManager.player.isFinished && !isLoading{
            nextLevel()
        }
        //            print(player.playerNode.position)
    }
    
    func setupWorld(){
        sceneView = SCNView()
        sceneView.frame = view.frame
        scene = SCNScene(named: "art.scnassets/World.scn")
        sceneView.scene = scene
        sceneView.delegate = self
        sceneView.showsStatistics = true
        view.addSubview(sceneView)
//        sceneView.scene!.physicsWorld.contactDelegate = self
//        sceneView.debugOptions = [.showPhysicsShapes]
    }
    
    
    func setupLevelManager(){
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
    }
    
    
    
    func nextLevel(){
        isLoading = true
        levelManager.endLevel()
        gestureManager.removeGesture(sceneView)
        level = level + 1 > 3 ? 1 : level + 1

        let _ = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { (Timer) in
            self.setupLevelManager()
            self.isLoading = false
            self.levelManager.setupLevel()
            self.levelManager.player.isFinished = false
            self.gestureManager.setupGesture(self.sceneView, self.levelManager)
        }
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension GameViewController : GameUIDelegate{
    func setupUI(){
        let size : CGFloat = 100
        let posX = view.frame.width - size - 50
        let posY : CGFloat = 12
        let frame = CGRect(x: posX, y: posY, width: size, height: size)
        let uiview = GameUIView(frame: frame)
        uiview.delegate = self
        //
        //        uiview.backgroundColor = .blue
        //        uiview.alpha = 0.3
        view.addSubview(uiview)
        //        let gameUI = GameUIView(frame : view.frame)
    }
    
    func pauseButton() {
        HapticGenerator().play(5)
        
        
    }
        
}
