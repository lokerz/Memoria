//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Player : SCNNode{
    var scaleMultiplier = 1
    
    override init() {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/player.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.scale = SCNVector3(scaleMultiplier, scaleMultiplier, scaleMultiplier)
        setupMovement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMovement(){
        
    }
    
}
