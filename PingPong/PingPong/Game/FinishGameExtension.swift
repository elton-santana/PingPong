//
//  FInishGameExtension.swift
//  PingPong
//
//  Created by Elton Santana on 09/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func gameIsOver() -> Bool{
        var isOver = false
        if Facade.shared.getLocalPlayerScore() >= self.maxScore ||
            Facade.shared.getOpponentPlayerScore() >= self.maxScore {
            isOver = true
        }
        return isOver
    }
    
    func finishGame(){
        
        let winnerName = Facade.shared.getPlayerWithBestScoreName()
        self.finishLabel?.text = "\(winnerName) won!!"
        
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        
        self.finishLabel?.run(fadeIn)
//        self.playAgainButton?.run(fadeIn)
        self.mainMenuButton?.run(fadeIn)
        
    }
    
    
}
