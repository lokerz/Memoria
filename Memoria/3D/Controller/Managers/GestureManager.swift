//
//  GestureExtension.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class GestureManager{
    static var instance = GestureManager()
    
    func setupGesture(_ sceneView : SCNView, _ levelManager : LevelManager){
        let tapGesture = UITapGestureRecognizer(target: levelManager, action: #selector(levelManager.handleTap(_:)))
        let panGesture = UIPanGestureRecognizer(target: levelManager, action: #selector(levelManager.handlePan(_:)))
        DispatchQueue.main.async {
            sceneView.addGestureRecognizer(tapGesture)
            sceneView.addGestureRecognizer(panGesture)
        }
    }
    
    func removeGesture(_ sceneView : SCNView){
        DispatchQueue.main.async{
            sceneView.gestureRecognizers?.forEach(sceneView.removeGestureRecognizer)
        }
    }
    
    
    
    
    
    
}
