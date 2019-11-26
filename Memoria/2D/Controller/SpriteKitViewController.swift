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
    var isActive = false
    
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
            spriteManager.setupDelegate(delegate : self)
        }
    }
}

extension SpriteKitViewController : SKSceneDelegate{
    func update(_ currentTime: TimeInterval, for scene: SKScene){
        if isActive {
            if spriteManager.isChangingToSceneKit {
                print(#function)
                spriteManager.isChangingToSceneKit = false
                self.delegate!.showSceneKit!(level : spriteManager.gameLevel)
            }
        }
    }
    
    
}
