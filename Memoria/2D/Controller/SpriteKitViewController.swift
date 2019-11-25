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

class SpriteKitViewController: UIViewController {
    
    @IBOutlet weak var mainSkView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainSkView.ignoresSiblingOrder = true
        setupSKView()
    }
    
    
    func setupSKView(){
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

}

