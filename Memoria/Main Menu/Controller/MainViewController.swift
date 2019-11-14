//
//  MainViewController.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 07/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainSkView: SKView!
    
    override func viewDidLoad() {
        
        mainSkView.ignoresSiblingOrder = true
        
        super.viewDidLoad()
        
        
        if let view = mainSkView {
            
            if let scene1 = SKScene(fileNamed: "MainMenu") {
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

