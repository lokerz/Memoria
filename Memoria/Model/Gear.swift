//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Gear : SCNNode, CAAnimationDelegate{
    var scaleMultiplier : Float = 1.0
    var velocity : Float = 5
    var movable = true
    var timer = Timer()
    var destination = SCNVector3()
    
    override init() {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/Gear.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        
        self.scale = SCNVector3Make(scaleMultiplier, scaleMultiplier, scaleMultiplier)
        self.position = SCNVector3Make(0, 0, 0)
//        addPhysicsBody()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPhysicsBody(){
        let scale = SCNVector3Make(1.0, 1.0, 1.0)
        let shape = SCNPhysicsShape(node: self, options: [SCNPhysicsShape.Option.scale : scale])
        let body = SCNPhysicsBody(type: .static, shape: shape)
        body.isAffectedByGravity = false
        self.physicsBody = body
    }
    
    func rotateGear(by angle : SCNVector4){
        self.rotation = angle
    }
    
    func stopRotate(){
        
    }
}
