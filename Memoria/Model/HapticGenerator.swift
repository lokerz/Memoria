//
//  HapticGenerator.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit
import CoreHaptics

class HapticGenerator : NSObject{
    
    static let instance = HapticGenerator()
    var hapticEngine : CHHapticEngine?
    var timer = Timer()
    var lastValue = 0
    var isHaptic = true
    
    override init() {
        super.init()
        do {
            hapticEngine = try CHHapticEngine()
            
            try hapticEngine?.start()
            
        } catch let error {
            print (error)
        }
    }
    
    func play(sharpnessValue : Float, intensityValue : Float){
        print(#function)
        if isHaptic {
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpnessValue) // The feel of  haptic event, from dull to sharp
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue) // How strong the haptic is
            // Some advanced parameters
            let attackTime = CHHapticEventParameter(parameterID: .attackTime, value: 0.2) // When to increase the intensity of the haptic.
            let releaseTime = CHHapticEventParameter(parameterID: .releaseTime, value: 0.8) // If you want the haptic to "fade", when
            //        let releaseTime = CHHapticEventParameter(parameterID: .sustained, value: 0.5) // If you want to sustain the haptic for its entire duration.
            
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness, attackTime, releaseTime], relativeTime: 0)
            
            do {
                let pattern = try CHHapticPattern(events: [event], parameters: [])
                let player = try hapticEngine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed perform haptic: \(error.localizedDescription).")
            }
        }
    }
    
    func play(value : Int, sharpnessValue : Float, intensityValue : Float){
        if isHaptic {
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpnessValue) // The feel of  haptic event, from dull to sharp
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue) // How strong the haptic is
            // Some advanced parameters
            let attackTime = CHHapticEventParameter(parameterID: .attackTime, value: 0.2) // When to increase the intensity of the haptic.
            let releaseTime = CHHapticEventParameter(parameterID: .releaseTime, value: 0.8) // If you want the haptic to "fade", when
            //        let releaseTime = CHHapticEventParameter(parameterID: .sustained, value: 0.5) // If you want to sustain the haptic for its entire duration.
            
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness, attackTime, releaseTime], relativeTime: 0)
            
            if lastValue != value {
                lastValue = value
                do {
                    let pattern = try CHHapticPattern(events: [event], parameters: [])
                    let player = try hapticEngine?.makePlayer(with: pattern)
                    try player?.start(atTime: 0)
                } catch {
                    print("Failed perform haptic: \(error.localizedDescription).")
                }
            }
        }
    }
    
    func play(_ i : Int) {
        if isHaptic {
            print("Running \(i)")
            
            
            
            switch i {
            case 1:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            case 2:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                
            case 3:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.warning)
                
            case 4:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                
            case 5:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                
            case 6:
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                
            default:
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
            }
        }
    }
}
