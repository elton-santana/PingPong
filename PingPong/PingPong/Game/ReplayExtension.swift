//
//  ReplayExtension.swift
//  PingPong
//
//  Created by Elton Santana on 25/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func restartMatch(){
        Facade.shared.restartMatch()
        self.updateScoreLabels()
        
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        
        self.finishLabel?.run(fadeOut)
        self.mainMenuButton?.run(fadeOut)
        
        if Facade.shared.localDeviceIsServer!{
            self.playAgainButton?.run(fadeOut, completion: { 
                self.restart()
            })
        }
    }
}
