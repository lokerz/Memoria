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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupUI()
        
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
        let posX = view.frame.width - 100
        let posY = 12
        let frame = CGRect(x: Int(posX), y: posY, width: 100, height: 100)
        let uiview = GameUIView(frame: frame)
        uiview.delegate = self
        //
        //        uiview.backgroundColor = .blue
        //        uiview.alpha = 0.3
        view.addSubview(uiview)
        //        let gameUI = GameUIView(frame : view.frame)
    }
    
    func pauseButton() {
        HapticGenerator().play(5)
    }
        
}
