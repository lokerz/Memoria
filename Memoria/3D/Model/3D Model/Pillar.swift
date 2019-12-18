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
    
    var pathManager = PathfindingManager.instance
    var levelManager = LevelManager()
    
    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3) {
        super.init()
        commonInit(on: position)
        
    }
    
    init(on position : SCNVector3, with rotation : SCNVector4) {
        super.init()
        commonInit(on: position)
        self.rotation = rotation
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit(on position : SCNVector3){
        guard let object = SCNScene(named: "art.scnassets/island.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
//            setupShader(for: node)
        }
        self.name = "Pillar"
        self.position = position
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
