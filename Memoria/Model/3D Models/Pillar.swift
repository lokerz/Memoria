//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Pillar : SCNNode{
    
    var isFinish = false
    
    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3) {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/pillar.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.name = "Pillar"
        self.position = position
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func moveDown(by val : Float, duration : TimeInterval){
        let y = position.y - val
        let destination = SCNVector3Make(position.x, y, position.z)
        
        let moveDown = SCNAction.move(to: destination, duration: duration)
        moveDown.timingMode = .easeInEaseOut
        
        let wait = SCNAction.wait(duration: 0.2)
        
        let sequence = SCNAction.sequence([wait,moveDown])
        self.runAction(sequence)
    }
}
