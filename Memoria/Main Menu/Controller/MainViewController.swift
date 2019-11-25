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
    var uiview = GameUIView()
    var spriteManager = SpriteManager.instance
    
    @IBOutlet weak var containerView: UIView!
    
    lazy var spriteViewController : SpriteKitViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SpriteKitViewController") as! SpriteKitViewController
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
        setupUI()
        showSpriteKit()
//        showSceneKit()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideUI()

    }
    
    
    func showSpriteKit(){
        gameViewController.view.isHidden = true
        spriteViewController.view.isHidden = false
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
        uiview.setupButton()
        view.addSubview(uiview)
    }
    
    func hideUI(){
        uiview.isHidden = true
    }
    
    func bringUIFront(){
        view.bringSubviewToFront(uiview)
    }
    
    func pauseButton() {
        
    }
    
    func exitButton() {
        showSpriteKit()
        let scene = spriteManager.callScene(index: -1)
        spriteViewController.mainSkView.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
        hideUI()
        saveGame()
    }
    
    func saveGame(){
        
    }
}

