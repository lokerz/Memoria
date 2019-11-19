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
    var  uiview = GameUIView()
    @IBOutlet weak var containerView: UIView!
    
    lazy var spriteViewController : MainMenuViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
        self.addChildController(viewController)
        return viewController
    }()
    
    lazy var gameViewController : GameViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.addChildController(viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpriteKit()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uiview.fadeInPauseButton()
    }
    
    func showSpriteKit(){
        spriteViewController.view.isHidden = false
        gameViewController.view.isHidden = true
    }
    
    func showSceneKit(){
        spriteViewController.view.isHidden = true
        gameViewController.view.isHidden = false
    }
    
    func addChildController(_ childController: UIViewController) {
        addChild(childController)
        containerView.addSubview(childController.view)
        childController.view.frame = containerView.bounds
        childController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childController.didMove(toParent: self)
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

extension MainViewController : GameUIDelegate{
    func setupUI(){
        uiview = GameUIView(frame: view.frame)
        uiview.delegate = self
        uiview.isMainMenu = true
        uiview.setupButton()
        view.addSubview(uiview)
    }
    
    func bringUIFront(){
        view.bringSubviewToFront(uiview)
    }
    
    func pauseButton() {
        
    }
    
    func exitButton() {
        
    }
}

