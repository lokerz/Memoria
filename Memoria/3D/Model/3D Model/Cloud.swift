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
        for node in object.rootNode.childNodes as [SCNNode]{
            tempNode.addChildNode(node)
        }
        clouds.append(tempNode)
        setCloud(to: object)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCloud(to: SCNScene){
    }
}
