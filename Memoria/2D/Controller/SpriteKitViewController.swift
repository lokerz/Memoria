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
    var spriteManager = SpriteManager.instance
    var delegate : TransitionDelegate?
    
    @IBOutlet weak var mainSkView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainSkView.ignoresSiblingOrder = true
        setupSKView()
    }
    
    
    func setupSKView(){
        if let view = mainSkView {
            spriteManager.setupView(view: view)
            spriteManager.callScene(index: 0)
        }
    }
    
    
}

