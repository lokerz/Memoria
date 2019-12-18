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
        tempNode.position = SCNVector3Make(0, -1.7, -16.6)
        for node in object.rootNode.childNodes as [SCNNode]{
            tempNode.addChildNode(node)
        }
        clouds.append(tempNode)
        
        guard let object2 = SCNScene(named: "art.scnassets/cloud2.scn") else { return }
        let tempNode2 = SCNNode()
        tempNode2.position = SCNVector3Make(10.5, -2.9, -15.6)
        for node in object2.rootNode.childNodes as [SCNNode]{
            tempNode2.addChildNode(node)
        }
        clouds.append(tempNode2)
        
        guard let object3 = SCNScene(named: "art.scnassets/cloud3.scn") else { return }
        let tempNode3 = SCNNode()
        tempNode3.position = SCNVector3Make(-18.2, -3.3, -15.2)
        for node in object3.rootNode.childNodes as [SCNNode]{
            tempNode3.addChildNode(node)
        }
        clouds.append(tempNode3)
        
//        setupCloud()
        
        self.addChildNode(tempNode)
        self.addChildNode(tempNode2)
        self.addChildNode(tempNode3)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCloud(){
        let move = SCNAction.move(by: SCNVector3Make(-1000, 0, 0), duration: 10)
        let reset = SCNAction.move(by: SCNVector3Make(1000, 0, 0), duration: 0)
        
        clouds[0].runAction(move){
            self.clouds[0].runAction(reset)
        }
    }
}
