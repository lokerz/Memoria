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

class SpriteKitController: UIViewController {

    @IBOutlet weak var spriteView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = spriteView {
            
            if let scene1 = SKScene(fileNamed: "MobilScene") {
                scene1.scaleMode = .resizeFill
                
                view.presentScene(scene1)
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
