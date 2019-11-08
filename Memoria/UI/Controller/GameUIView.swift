//
//  GameUIViewController.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 06/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit
import GLKit

@objc protocol GameUIDelegate{
    @objc optional func pauseButton()
}

class GameUIView: UIView{
    @IBOutlet var contentView: UIView!
    @IBOutlet var pauseButtonOutlet: UIButton!
    
    var delegate : GameUIDelegate?
    var isToggle = false
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        commonInit()
        setupSize(frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("GameUIView", owner: self, options: nil)
        self.addSubview(contentView)
        
    }
    
    func setupSize(_ frame : CGRect){
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        contentView.frame = frame
        self.backgroundColor = .purple
        contentView.backgroundColor = .blue
    }
    
    @IBAction func pauseButtonAction(_ sender: Any) {
        self.delegate?.pauseButton?()
        pauseButtonOutlet.isHighlighted = false
        isToggle = !isToggle
        rotate()
    }
    
    func rotate(){
        let degree = isToggle ? GLKMathDegreesToRadians(-90) : 0 //the value in degrees
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.pauseButtonOutlet.transform = CGAffineTransform.init(rotationAngle: CGFloat(degree))
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
