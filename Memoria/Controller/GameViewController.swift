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
    var loadingView : UIView?
    
    var scene : SCNScene!
    var rootNode = SCNNode()
    var level = 1
    var isLoading = false
    
    var player = Player()
    var gears = [Gear]()
    var halfGears = [HalfGear]()
    var platforms = [Platform]()
    var finishPillar = Pillar()
    var black = Black()
    
    var gravity : Float = -5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWorld()
        setupLevel()
        setupGesture()
    }
    
    func setupWorld(){
        sceneView = self.view as! SCNView
        scene = SCNScene(named: "art.scnassets/World.scn")
        sceneView.prepare(scene, shouldAbortBlock: nil)
        sceneView.scene = scene
        sceneView.delegate = self
//        sceneView.scene!.physicsWorld.contactDelegate = self
        sceneView.scene!.physicsWorld.gravity = SCNVector3Make(0, gravity, 0)
//        sceneView.showsStatistics = true
//        sceneView.debugOptions = [.showPhysicsShapes]
        rootNode = sceneView.scene!.rootNode
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        player.checkPosition()
        
        if player.isFinished && !isLoading{
            nextLevel()
        }
//        print(player.playerNode.position)
    }
    
    
}
