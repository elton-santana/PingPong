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
        
        let xForce = self.motionManager.gyroData!.rotationRate.x

        let dxVelocity = self.playerRacket?.physicsBody?.velocity.dx
        self.playerRacket?.physicsBody?.velocity.dx = dxVelocity! + 50*CGFloat(xForce)
        
        //"lock" the racket on the game area
        
        if (playerRacket?.position.x)! > self.frame.maxX - ((playerRacket?.size.width)!){
            playerRacket?.position.x = self.frame.maxX - ((playerRacket?.size.width)!)
        }
        if (playerRacket?.position.x)! < self.frame.minX + ((playerRacket?.size.width)!){
            playerRacket?.position.x = self.frame.minX + ((playerRacket?.size.width)!)
        }
        
        
    }
    

    
}
