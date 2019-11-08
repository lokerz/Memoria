//
//  Level1Extension.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 22/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class LevelManager : NSObject {
    var level = 0
    
    //scene variables
    var sceneView : SCNView! {
        didSet {
            if let scene = sceneView.scene {
               rootNode = scene.rootNode
            }
        }
    }
    var rootNode = SCNNode()
    var pathfinder = PathfindingManager()
    //
    
    // 3D Objects
    var player = Player()
    var gears = [Gear]()
    var pillars = [Pillar]()
    var halfGears = [HalfGear]()
    var platforms = [Platform]()
    var black = Black()
    
    // Boolean Variables
    var isLoading = false
    var isPanning = false
    //

    // Gesture Variables
    var location : CGPoint!
    var hitResults = [SCNHitTestResult]()
    var translation : CGPoint!
    //
    
    
    func setupLevel(){
        resetLevel()
        black.fadeOut()
    }
    
    func resetLevel(){
        for child in rootNode.childNodes{
            if child.name != "camera" && child.name != "staticLight"{
                child.removeFromParentNode()
            }
        }
        rootNode.addChildNode(black)
        gears.removeAll()
        platforms.removeAll()
        halfGears.removeAll()
    }
    
    func endLevel(){
        pillars.last!.moveDown(by: 20, duration: 3)
        black.fadeIn()
    }
    
    func autoRotateSystem(){
        for gear in gears {
            gear.rotateGear(by: 0.2)
        }
    }
    
    func checkPlayer(){
        player.checkPosition()
    }
    
    @objc func handleTap(_ gestureRecognizer : UIGestureRecognizer){
        location = gestureRecognizer.location(in: sceneView)
        hitResults = sceneView.hitTest(location, options: [:])
        
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let tappedPiece = hitResults.first!.node
            
            if tappedPiece.name == "gear" || tappedPiece.name == "pillar"{
                player.movePlayer(hitTestResult: hitResults.first!)
            }
        }
    }
    
    @objc func handlePan(_ gestureRecognizer : UIPanGestureRecognizer){
        isPanning = gestureRecognizer.state == .ended ? false : true
        location = gestureRecognizer.location(in: sceneView)
        translation = gestureRecognizer.translation(in: sceneView)
        hitResults = sceneView.hitTest(location, options: [:])
        
    }
    
}