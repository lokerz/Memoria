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
    
    var uiview = GameUIView()

    override func viewDidLoad() {
        
        mainSkView.ignoresSiblingOrder = true
        
        super.viewDidLoad()
        
        setupBackground()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uiview.fadeInPauseButton()
    }
    
    func setupBackground(){
        let backgroundImage = UIImage(named: "main1")
        
        backgroundView.frame = view.bounds
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.clipsToBounds = true
        backgroundView.image = backgroundImage
        backgroundView.center = view.center
        
        
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
    }
 
}

extension MainViewController : GameUIDelegate{
    func setupUI(){
        uiview = GameUIView(frame: view.frame)
        uiview.delegate = self
        uiview.isMainMenu = true
        uiview.setupButton()
        view.addSubview(uiview)
    }
    
    func pauseButton() {
        
    }
    
    func exitButton() {
        
    }
        
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

