//
//  GameViewController.swift
//  Memoria
//
//  Created by Delvin on 21/10/19.
//  Copyright © 2019 Delvin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            if let scene1 = SKScene(fileNamed: "MobilScene") {
                scene1.scaleMode = .resizeFill
                
                view.presentScene(scene1)
            }
            else if let scene2 = SKScene(fileNamed: "PhotoScene") {

                scene2.scaleMode = .resizeFill
                
                // Present the scene
                view.presentScene(scene2)
            }
            else if let scene3 = SKScene(fileNamed: "MobilScene") {
                scene3.scaleMode = .resizeFill
                
                // Present the scene
                view.presentScene(scene3)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .landscape
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
