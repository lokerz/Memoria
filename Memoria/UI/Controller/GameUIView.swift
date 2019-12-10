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
    @objc optional func exitButton()
}

class GameUIView: UIView{
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pauseButtonOutlet: UIButton!
    @IBOutlet weak var soundButtonOutlet: UIButton!
    @IBOutlet weak var hapticButtonOutlet: UIButton!
    @IBOutlet weak var exitButtonOutlet: UIButton!
    var buttons = [UIButton]()
    var centers = [CGPoint]()
    var buttonColor = #colorLiteral(red: 1, green: 0.8980392157, blue: 0.5450980392, alpha: 1)
    
    var delegate : GameUIDelegate?
    var isToggle = false
    
    var soundCenter = CGPoint()
    var hapticCenter = CGPoint()
    var exitCenter = CGPoint()
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        commonInit()
        setupSize(frame)
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("GameUIView", owner: self, options: nil)
        self.addSubview(contentView)
    }
    
    func setupSize(_ frame : CGRect){
        let trailingValue : CGFloat = 50
        let frameSize : CGFloat = 100
        let posX = frame.width - frameSize - trailingValue
        let posY : CGFloat = 12
        let viewFrame = CGRect(x: posX, y: posY, width: frameSize, height: frameSize)
        let contentFrame = CGRect(x: 0, y: 0, width: frameSize, height: frameSize)
        self.frame = viewFrame
        contentView.frame = contentFrame
        //        contentView.autoresizesSubviews = false
    }
    
    func setupButton(){
//        pauseButtonOutlet.setTitleColor(buttonColor, for: .normal)
        hapticButtonOutlet.setTitleColor(HapticGenerator.instance.isHaptic ? .white : .gray, for: .normal)
       
        buttons.append(soundButtonOutlet)
        buttons.append(hapticButtonOutlet)
        buttons.append(exitButtonOutlet)
        
        setupShadow()
    }
    
    func setupShadow(){
        setShadow(button: pauseButtonOutlet)
        for button in buttons{
            setShadow(button: button)
        }
    }
    
    func setShadow(button : UIButton){
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.masksToBounds = true
    }
    
    func resetButton(){
        pauseButtonOutlet.transform = CGAffineTransform(rotationAngle: 0)
        buttons.forEach { (button) in
            button.alpha = 0
        }
        isToggle = false
    }
    
//    func fadeInPauseButton(){
//        pauseButtonOutlet.alpha = 0
//        fadeIn(button: pauseButtonOutlet, duration: 2)
//    }
//
    func fadeIn(){
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 1
        })
    }
    
    func fadeOut(){
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 0
        })
    }
    
    func animateButton(){
        for i in 0..<buttons.count{
            if isToggle {
                fadeIn(button: buttons[i], duration: 0.3)
//                move(button: buttons[i], to: centers[i], duration: 0.5)
                
            } else {
                fadeOut(button: buttons[i], duration: 0.3)
//                move(button: buttons[i], to: pauseButtonOutlet.center, duration: 0.5)
            }
        }
    }
    
    @IBAction func pauseButtonTouchDown(_ sender: Any) {
        HapticGenerator.instance.play(5)
    }
    
    @IBAction func pauseButtonAction(_ sender: Any) {
        self.delegate?.pauseButton?()
        //        pauseButtonOutlet.isHighlighted = false
        isToggle = !isToggle
        rotate(button : pauseButtonOutlet, duration: 0.3)
        animateButton()
    }
    
    @IBAction func soundButtonAction(_ sender: Any) {
        //SoundGenerator.instance.isSound = !SoundeGenerator.instance.isSound
        HapticGenerator.instance.play(4)
        FirstPlayer.instance.volume = FirstPlayer.instance.volume == 1 ? 0 : 1
        soundButtonOutlet.setTitleColor(FirstPlayer.instance.volume == 1 ? .white : .gray, for: .normal)
        
    }
    
    @IBAction func hapticButtonAction(_ sender: Any) {
        HapticGenerator.instance.isHaptic = !HapticGenerator.instance.isHaptic
        hapticButtonOutlet.setTitleColor(HapticGenerator.instance.isHaptic ? .white : .gray, for: .normal)
        HapticGenerator.instance.play(4)
    }
    
    @IBAction func exitButtonAction(_ sender: Any) {
        self.delegate?.exitButton?()
        
        FirstPlayer.instance.player?.stop()
        SecondPlayer.instance.player?.stop()
        pauseButtonAction(self)
    }
    
    @IBAction func exitButtonTouchDown(_ sender: Any) {
        HapticGenerator.instance.play(4)
    }
    
    func rotate(button : UIButton, duration : TimeInterval){
        let degree = isToggle ? GLKMathDegreesToRadians(-180) : 0 //the value in degrees
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            button.titleLabel?.transform = CGAffineTransform(rotationAngle: CGFloat(degree))
        })
    }
    
    func fadeIn(button : UIButton, duration : TimeInterval){
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            button.alpha = 1
        })
    }
    
    func fadeOut(button : UIButton, duration : TimeInterval){
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            button.alpha = 0
        })
    }
    
    func move(button : UIButton, to point : CGPoint, duration : TimeInterval){
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            button.center = point
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
