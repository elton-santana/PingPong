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
        if Facade.shared.getLocalPlayerScore() >= self.maxScore || Facade.shared.getOpponentPlayerScore() >= self.maxScore {
            isOver = true
        }
        return isOver
    }
    
    func finishGame(){
        
        self.finishLabel?.alpha = 0
        self.playAgainButton?.alpha = 0
        self.mainMenuButton?.alpha = 0
        self.addChild(self.finishLabel!)
        self.addChild(self.playAgainButton!)
        self.addChild(self.mainMenuButton!)
        
        let winnerName = Facade.shared.getPlayerWithBestScoreName()
        self.finishLabel?.text = "\(winnerName) won!!"
        
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        
        self.finishLabel?.run(fadeIn)
        self.playAgainButton?.run(fadeIn)
        self.mainMenuButton?.run(fadeIn)
        
    }
    
    
}
