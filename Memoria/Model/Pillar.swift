//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Pillar : SCNNode{
    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3) {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/pillar.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        
        moveDown(to: position)
//        self.position = position
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func moveDown(to position : SCNVector3){
        let y = position.y + 3
        self.position = SCNVector3Make(position.x, y, position.z)
        
        let moveDown = SCNAction.move(to: position, duration: 3)
        moveDown.timingMode = .easeInEaseOut;
        self.runAction(moveDown) {
            
        }
        
    }
}
