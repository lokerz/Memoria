//
//  GestureExtension.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

extension GameViewController {
    func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        sceneView.addGestureRecognizer(panGesture)
    }
    
    @objc func handleTap(_ gestureRecognizer : UIGestureRecognizer){
        let location = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(location, options: [:])

        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let tappedPiece = hitResults[0].node
            
            if tappedPiece.name == "floor"{
//                player.movePlayer2(hitTestResult : hitResults.first!)
                player.movePlayer(hitTestResult: hitResults.first!)
            }
        }
    }
    
    @objc func handlePan(_ gestureRecognizer : UIPanGestureRecognizer){
        let location = gestureRecognizer.location(in: sceneView)
        let translation = gestureRecognizer.translation(in: sceneView)
        let hitResults = sceneView.hitTest(location, options: [:])
        var i = 0
        
        if hitResults.count > 0 {
            let pannedPiece = hitResults.first?.node
            if pannedPiece?.name == "gear"{
                print(gear.rotation)
                let x = Float(translation.x)
                let y = Float(-translation.y)
                let anglePan = sqrt(pow(x,2)+pow(y,2))*(Float)(Double.pi)/180.0
                var rotationVector = SCNVector4()
                rotationVector.x = 0
                rotationVector.y = x
                rotationVector.z = 0
                rotationVector.w = anglePan/2
                
                gear.rotateGear(by : rotationVector)
                
                print(x.truncatingRemainder(dividingBy: 10))
                i += Int(translation.x)
                if (i % 10 == 0){
                    HapticGenerator().play(6)
                }
            }
        }
    }
    
    
    
}
