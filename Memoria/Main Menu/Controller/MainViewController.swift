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

@objc protocol TransitionDelegate{
    @objc optional func showSpriteKit(index : Int, transition : SKTransition)
    @objc optional func showSceneKit(level : Int)
}

class MainViewController: UIViewController, TransitionDelegate {
    var uiview = GameUIView()
    var spriteManager = SpriteManager.instance
    
    @IBOutlet weak var containerView: UIView!
    
    lazy var spriteViewController : SpriteKitViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SpriteKitViewController") as! SpriteKitViewController
        self.addChildController(viewController)
        viewController.delegate = self
        return viewController
    }()
    
    lazy var gameViewController : GameViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.addChildController(viewController)
        viewController.delegate = self
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showSpriteKit(index: -1, transition: .fade(withDuration: 0.5))
//        showSceneKit(level: 3)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
    func showSpriteKit(index : Int, transition : SKTransition){
        DispatchQueue.main.async {
            self.spriteManager.callScene(index: index)
            self.gameViewController.view.isHidden = true
            self.spriteViewController.view.isHidden = false
            self.gameViewController.isActive = false
            self.spriteViewController.isActive = true

        }
    }
    
    func showSceneKit(level : Int){
        print(#function, level)
        DispatchQueue.main.async {
            self.gameViewController.setup(level: level)
            self.gameViewController.view.isHidden = false
            self.spriteViewController.view.isHidden = true
            self.uiview.isHidden = false
            self.gameViewController.isActive = true
            self.spriteViewController.isActive = false

        }
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
        uiview.isHidden = true
    }
    
    
    func bringUIFront(){
        view.bringSubviewToFront(uiview)
    }
    
    func pauseButton() {
        
    }
    
    func exitButton() {
        showSpriteKit(index: -1, transition: .fade(withDuration: 0.5))
        uiview.isHidden = true
        saveGame()
    }
    
    func saveGame(){
        
    }
}

