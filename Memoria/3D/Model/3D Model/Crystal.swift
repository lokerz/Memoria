//
//  Player.swift
//
//  Created by Ridwan Abdurrasyid on 17/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

class Crystal : SCNNode{
    override init(){
        super.init()
    }
    
    init(amount : Int){
        super.init()
        spawnCrystal(amount)
        self.name = "crystal"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func spawnCrystal(_ amount : Int){
        for _ in 0..<amount {
            let crystal = SCNNode()
            guard let object = SCNScene(named: "art.scnassets/Crystal.scn") else { return }
            for node in object.rootNode.childNodes as [SCNNode]{
                crystal.addChildNode(node)
            }
            crystal.position = randomizePos()
            let rotate = SCNAction.rotate(by: CGFloat(GLKMathDegreesToRadians(Float.random(in: -180...180))), around: SCNVector3Make(Float(Int.random(in: -1...1)), Float(Int.random(in: -1...1)), Float(Int.random(in: -1...1))), duration: 1)
            let rotate2 = SCNAction.repeatForever(rotate)
            crystal.runAction(rotate2)
            self.addChildNode(crystal)
        }
    }
    
    func randomizePos() -> SCNVector3 {
        let x = random(min: -10, max: 10)
        let y = random(min: -2, max: 2)
        let z = random(min: -5, max: -2)
        return SCNVector3Make(x, y, z)
    }
    
    func random(min: Float, max: Float) -> Float {
        return Float.random(in: min...max)
    }
    
}
