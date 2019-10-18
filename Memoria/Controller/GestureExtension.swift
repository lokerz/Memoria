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
        sceneView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gestureRecognizer : UIGestureRecognizer){
        let location = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(location, options: [:])

        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let tappedPiece = hitResults[0].node
            
            if tappedPiece.name == "floor"{
//                player.movePlayer(hitTestResult : hitResults.first!)
                player.movePlayer(hitTestResult: hitResults.first!)
            }
        }
    }
    
    
    
}
