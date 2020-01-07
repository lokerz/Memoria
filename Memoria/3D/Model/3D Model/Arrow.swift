//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

enum arrowAnimation {
    case none
    case tap
    case pan
}


class Arrow : SCNNode{
    var type : arrowAnimation = .none
    
    override init(){
        super.init()
    }
    
    init(on position : SCNVector3, with rotation : SCNVector4, delay : Double ) {
        super.init()
        guard let object = SCNScene(named: "art.scnassets/arrow.scn") else { return }
        for node in object.rootNode.childNodes as [SCNNode]{
            self.addChildNode(node)
        }
        self.name = "gear"
        self.position = position
        self.rotation = rotation
        self.opacity = 0
        fadeIn(with : delay)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func fadeIn(with delay : Double){
        let wait = SCNAction.wait(duration: delay)
        let fadeIn = SCNAction.fadeIn(duration: 1)
        self.runAction(wait){
            self.runAction(fadeIn)
        }
    }
    
    func fadeOut(){
        let fadeOut = SCNAction.fadeOut(duration: 1)
        self.runAction(fadeOut)
    }
    
    func tapAnimation(){
        type = .tap
//        let newPosition = SCNVector3Make(self.position.x, self.position.y + 1, self.position.z)
//        self.position = newPosition

        let downAction = SCNAction.moveBy(x: 0, y: -0.5, z: 0, duration: 1).easeInOut()
        let upAction = SCNAction.moveBy(x: 0, y: 0.5, z: 0, duration: 1).easeInOut()
        
        let sequence = SCNAction.sequence([upAction, downAction])
        let repeatSequence = SCNAction.repeatForever(sequence)
        self.runAction(repeatSequence)
        
        let rotate = SCNAction.rotate(by: CGFloat(GLKMathDegreesToRadians(360)), around: SCNVector3Make(0, 1, 0), duration: 10)
        let repeatRotate = SCNAction.repeatForever(rotate)
        self.runAction(repeatRotate)
    }
    
    func panAnimation(){
        type = .pan
        
        let rightAction = SCNAction.moveBy(x: 1, y: 0, z: 0, duration: 2).easeInOut()
        let resetAction = SCNAction.moveBy(x: -1, y: 0, z: 0, duration: 0.2).easeInOut()
        
        let sequence = SCNAction.sequence([rightAction, resetAction])
        let repeatSequence = SCNAction.repeatForever(sequence)
        self.runAction(repeatSequence)
        
        let rotate = SCNAction.rotate(by: CGFloat(GLKMathDegreesToRadians(10)), around: SCNVector3Make(0, 1, 0), duration: 2)
        let resetRotate = SCNAction.rotate(by: -CGFloat(GLKMathDegreesToRadians(10)), around: SCNVector3Make(0, 1, 0), duration: 0.2)
        let sequenceRotate = SCNAction.sequence([rotate, resetRotate])
        let repeatRotate = SCNAction.repeatForever(sequenceRotate)
//        self.runAction(repeatRotate)
        
    }
}
