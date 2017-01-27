//
//  RacketMoveExtension.swift
//  PingPong
//
//  Created by Elton Santana on 09/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion

extension GameScene{
    
    func moveRacket() {
        
        let yGForce = self.motionManager.deviceMotion!.attitude.pitch
      

        let dxVelocity = self.playerRacket?.physicsBody?.velocity.dx
        
        self.playerRacket?.physicsBody?.velocity.dx = dxVelocity! + 100*CGFloat(yGForce)
        
        //"lock" the racket on the game area
        
        if (playerRacket?.position.x)! > self.frame.maxX - ((playerRacket?.size.width)!*(0.6)){
            playerRacket?.position.x = self.frame.maxX - ((playerRacket?.size.width)!*(0.6))
            self.playerRacket?.physicsBody?.velocity.dx = 0
        }
        if (playerRacket?.position.x)! < self.frame.minX + ((playerRacket?.size.width)!*(0.6)){
            playerRacket?.position.x = self.frame.minX + ((playerRacket?.size.width)!*(0.6))
            self.playerRacket?.physicsBody?.velocity.dx = 0
        }
    }
    
}
