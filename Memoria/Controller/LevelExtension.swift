//
//  Level1Extension.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 22/10/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit

extension GameViewController {
    
    func setupLevel(){
        resetLevel()
        print("level", level)
        
        switch level {
        case 1 : setupLevelOne()
        case 2 : setupLevelThree()
        default : setupLevelTwo()
        }
        black.fadeOut()
    }
    
    func resetLevel(){
        level = level > 3 ? 1 : level
        for child in rootNode.childNodes{
            print(child.name)
            if child.name != "camera" && child.name != "staticLight"{
                child.removeFromParentNode()
            }
        }
        rootNode.addChildNode(black)
    }
    
    func nextLevel(){
        print(#function)
        isLoading = true
        finishPillar.moveDown(from: finishPillar.position, by: 20, duration: 3)
        black.fadeIn()
        let timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { (Timer) in
            self.level += 1
            self.setupLevel()
            self.isLoading = false
            self.player.isFinished = false
        }
    }
    
}
