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
    let player = Player()
    let gear = Gear()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupPlayer()
        setupGear()
        setupGesture()
    }
    
    func setupScene(){
        sceneView = self.view as! SCNView
//        sceneView.allowsCameraControl = true
        scene = SCNScene(named: "art.scnassets/Level1.scn")
        sceneView.scene = scene
        sceneView.delegate = self
    }
    
    func setupPlayer(){
        sceneView.scene?.rootNode.addChildNode(player)
    }
    
    func setupGear(){
        sceneView.scene?.rootNode.addChildNode(gear)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        player.synchronize()
        print(player.position)

    }
    
}
