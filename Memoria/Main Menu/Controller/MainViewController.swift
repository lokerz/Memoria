//
//  MainViewController.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 07/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIImageView!
    
    var uiview = GameUIView()

    override func viewDidLoad() {
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
        view.addSubview(uiview)
    }
    
    func pauseButton() {
        
    }
    
    func exitButton() {
        
    }
        
}
