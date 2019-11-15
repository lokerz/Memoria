//
//  PillarPath.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 12/11/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import GameplayKit


class PlatformPath : Platform {
    var coordinates = [SCNVector3]()
    var nodes = [GKGraphNode]()
    
    func setupPath(){
        setupCoordinates()
        setupNodes()
        pathManager.delegate = self
    }
    
    func setupCoordinates(){
        coordinates.append(SCNVector3Make(position.x, 0, position.z))
    }
    
    func setupNodes(){
        nodes.append(GKGraphNode())
    }
    
    override func move(by translation: CGPoint) {
        super.move(by: translation)
        checkHeight()
    }
    
    func checkHeight(){
        let node = nodes.first!
        
        if self.position.y <= minHeight {
            pathManager.addConnection(from: node , with: .nextNode)
            pathManager.addConnection(from: node, with: .previousNode)
        } else {
            pathManager.removeConnection(from: node, with: .nextNode)
            pathManager.removeConnection(from: node, with: .previousNode)
        }
    }
}

extension PlatformPath : PathManagerDelegate{
    func pathInitDetails() {
        let node = nodes.first!
        pathManager.removeConnection(from: node, with: .nextNode)
        pathManager.removeConnection(from: node, with: .previousNode)
    }
}
