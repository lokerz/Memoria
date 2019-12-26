//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Cloud : SCNNode{
    var clouds = [SCNNode]()
    
    override init(){
        super.init()
        
        guard let object = SCNScene(named: "art.scnassets/cloud1.scn") else { return }
        let tempNode = SCNNode()
        tempNode.name = "Cloud1"
        tempNode.position = SCNVector3Make(0, -1.7, -16.6)
        for node in object.rootNode.childNodes as [SCNNode]{
            tempNode.addChildNode(node)
        }
        clouds.append(tempNode)
        
        guard let object2 = SCNScene(named: "art.scnassets/cloud2.scn") else { return }
        let tempNode2 = SCNNode()
        tempNode2.name = "Cloud2"
        tempNode2.position = SCNVector3Make(14.5, -2.9, -15.6)
        for node in object2.rootNode.childNodes as [SCNNode]{
            tempNode2.addChildNode(node)
        }
        clouds.append(tempNode2)
        
        guard let object3 = SCNScene(named: "art.scnassets/cloud3.scn") else { return }
        let tempNode3 = SCNNode()
        tempNode3.name = "Cloud3"
        tempNode3.position = SCNVector3Make(-13.2, -3.3, -15.2)
        for node in object3.rootNode.childNodes as [SCNNode]{
            tempNode3.addChildNode(node)
        }
        clouds.append(tempNode3)
        
        setupCloud()
        
        self.addChildNode(tempNode)
        self.addChildNode(tempNode2)
        self.addChildNode(tempNode3)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCloud(){
        let duration = 600.0
        let moveByVal : CGFloat = -50.0
        let resetVal : CGFloat = 100.0
        
        let move = SCNAction.moveBy(x: moveByVal, y: 0, z: 0, duration: duration*2/3)
        let reset = SCNAction.moveBy(x: resetVal, y: 0, z: 0, duration: 0)
        let sequence = SCNAction.sequence([move,reset])
        let repeatAction = SCNAction.repeatForever(sequence)
        clouds[0].runAction(repeatAction)
        
        let move2 = SCNAction.moveBy(x: moveByVal, y: 0, z: 0, duration: duration*2)
        let reset2 = SCNAction.moveBy(x: resetVal, y: 0, z: 0, duration: 0)
        let sequence2 = SCNAction.sequence([move2,reset2])
        let repeatAction2 = SCNAction.repeatForever(sequence2)
        clouds[1].runAction(repeatAction2)
        
        let move3 = SCNAction.moveBy(x: moveByVal, y: 0, z: 0, duration: duration)
        let reset3 = SCNAction.moveBy(x: resetVal, y: 0, z: 0, duration: 0)
        let sequence3 = SCNAction.sequence([move3,reset3])
        let repeatAction3 = SCNAction.repeatForever(sequence3)
        clouds[2].runAction(repeatAction3)
    }
}
