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
    
    init(on position : SCNVector3, isFinish : Bool) {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/pillar.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.position = position
        self.isFinish = isFinish
        if !isFinish {
            moveDown(from: position, by: 5, duration: 3)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func moveDown(from pos1 : SCNVector3, by val : Float, duration : TimeInterval){
        let y = pos1.y - val
        let position = SCNVector3Make(pos1.x, y, pos1.z)
        
        let moveDown = SCNAction.move(to: position, duration: duration)
        moveDown.timingMode = .easeInEaseOut
        
        let wait = SCNAction.wait(duration: 0.2)
        
        let sequence = SCNAction.sequence([wait,moveDown])
        self.runAction(sequence)
    }
}
