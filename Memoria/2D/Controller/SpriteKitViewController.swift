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
    }
    
    
    func setupSKView(){
        if let view = mainSkView {
            view.ignoresSiblingOrder = true
            spriteManager.setupView(view: view)
            spriteManager.setupDelegate(delegate : self)
//            mainSkView.showsFPS = true
            //            spriteManager.callScene(index: 0, transition: .fade(withDuration: 1))
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
            
            if spriteManager.sceneNumber > 1 && spriteManager.sceneNumber <= spriteManager.scenes.count {
                self.delegate!.setupUI!(state : 1)
            } else {
                self.delegate!.setupUI!(state : 0)
            }
        }
    }
    
    
}
