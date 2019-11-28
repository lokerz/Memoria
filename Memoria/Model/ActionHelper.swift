//
//  SKActionHelper.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 28/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SpriteKit
import SceneKit

extension SKAction {
    func easeInOut() -> SKAction{
        self.timingMode = .easeInEaseOut
        return self
    }
    
    func easeIn() -> SKAction{
        self.timingMode = .easeIn
        return self
    }
    
    func easeOut() -> SKAction {
        self.timingMode = .easeOut
        return self
    }
}

extension SCNAction {
    func easeInOut() -> SCNAction{
        self.timingMode = .easeInEaseOut
        return self
    }
    
    func easeIn() -> SCNAction{
        self.timingMode = .easeIn
        return self
    }
    
    func easeOut() -> SCNAction {
        self.timingMode = .easeOut
        return self
    }
}
