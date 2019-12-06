//
//  SpriteKitHelper.swift
//  Memoria
//
//  Created by Ridwan Abdurrasyid on 06/12/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SpriteKit

extension SKView{
    func removeGestures(){
        if self.gestureRecognizers != nil {
            for gesture in self.gestureRecognizers!{
                self.removeGestureRecognizer(gesture)
            }
        }
    }
}
