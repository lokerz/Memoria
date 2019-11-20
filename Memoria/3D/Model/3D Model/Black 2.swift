//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Black : SCNNode{
    override init(){
        super.init()
        guard let object = SCNScene(named: "art.scnassets/black.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.name = "Black"
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func fadeIn(){
        let wait = SCNAction.wait(duration: 0.2)
        let fadeIn = SCNAction.fadeIn(duration: 2)
        fadeIn.timingMode = .easeIn
        let sequence = SCNAction.sequence([wait, fadeIn])
        self.runAction(sequence)
    }
    
    func fadeOut(){
        let wait = SCNAction.wait(duration: 0.2)
        let fadeOut = SCNAction.fadeOut(duration: 3)
        fadeOut.timingMode = .easeOut
        let sequence = SCNAction.sequence([wait, fadeOut])
        self.runAction(sequence)
    }
}
