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
    @objc optional func setupUI(state : Int)
}

class MainViewController: UIViewController {
    var loadingView = UIView()
    var uiview = GameUIView()
    var spriteManager = SpriteManager.instance
    var label = UILabel()
    
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
        setupLoadingView()
        spriteViewController.setupSKView()
        showSpriteKit(index: -1, transition: .fade(withDuration: 1))
//        showSceneKit(level: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    func setupLoadingView(){
        loadingView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        loadingView.backgroundColor = .white
        loadingView.alpha = 0
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge{
        return [.all]
    }
}

extension MainViewController : GameUIDelegate{
    func setupUI(){
        uiview = GameUIView(frame: view.frame)
        uiview.delegate = self
        uiview.setupButton()
        view.addSubview(uiview)
        uiview.alpha = 0
        
        let frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        label = UILabel(frame: frame)
        label.center = view.center
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Pigiarniq", size: 14)
        view.addSubview(label)
    }
    
    
    func bringUIFront(){
        view.bringSubviewToFront(uiview)
    }
    
    func pauseButton() {
        
    }
    
    func exitButton() {
        showAlert()
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Exit Chapter?", message: nil, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.saveGame()
            self.showSpriteKit(index: -1, transition: .fade(withDuration: 0.5))
            self.uiview.fadeOut()
            FirstPlayer.instance.player?.stop()
            BGMPlayer.instance.player?.stop()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    func showText(_ text: String){
        label.alpha = 1
        label.text = text
        view.bringSubviewToFront(label)
        UIView.animate(withDuration: 1, delay: 0.5, animations: {
            self.label.alpha = 0
        }) { (Bool) in
        }
    }
    
    func saveGame(){
        
    }
}

extension MainViewController : TransitionDelegate {
    func setupUI(state: Int) {
        if state == 1 && uiview.alpha == 0{
            DispatchQueue.main.async {
                self.uiview.fadeIn()
            }
        } else if state == 0 && uiview.alpha != 0{
            DispatchQueue.main.async {
                self.uiview.fadeOut()
            }
        }
    }
    
    func showSpriteKit(index : Int, transition : SKTransition){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, animations: {
                self.loadingView.alpha = 1
            }) { _ in
                self.spriteManager.callScene(index: index, transition: transition)
                self.gameViewController.view.isHidden = true
                self.spriteViewController.view.isHidden = false
                self.gameViewController.isActive = false
                self.spriteViewController.isActive = true
                UIView.animate(withDuration: 1, animations: {
                    self.loadingView.alpha = 0
                }) { _ in
                    
                }
            }
        }
    }
    
    func showSceneKit(level : Int){
        print(#function, level)

        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, animations: {
                self.loadingView.alpha = 1
            }) { _ in
                self.gameViewController.setup(level: level)
                self.gameViewController.view.isHidden = false
                self.spriteViewController.view.isHidden = true
                self.gameViewController.isActive = true
                self.spriteViewController.isActive = false
                UIView.animate(withDuration: 1, animations: {
                    self.loadingView.alpha = 0
                }) { _ in
                    self.uiview.fadeIn()
                }
            }
        }

    }
}
