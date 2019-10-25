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

class GameViewController: UIViewController, SCNSceneRendererDelegate, SCNPhysicsContactDelegate {

    var sceneView : SCNView!
    var scene : SCNScene!
    var player = Player()
    var gears = [Gear]()
    var gear = Gear()
    var gear2 = Gear()
    
    var gravity : Float = -9.8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupLevelOne()
        setupGesture()
    }
    
    func setupScene(){
        sceneView = self.view as! SCNView
        scene = SCNScene(named: "art.scnassets/World.scn")
        sceneView.scene = scene
        sceneView.delegate = self
        sceneView.scene!.physicsWorld.gravity = SCNVector3Make(0, gravity, 0)
        sceneView.scene!.physicsWorld.contactDelegate = self
        sceneView.debugOptions = .showPhysicsShapes
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        player.checkPosition()
//        print(player.playerNode.physicsBody!.friction, gear.gearNode.physicsBody!.friction)
        
        for gear in gears {
            gear.lock()
        }
    }
}
