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
        
        let XForce = self.motionManager.accelerometerData!.acceleration.x
        
            let dxVelocity = self.playerRacket?.physicsBody?.velocity.dx
            self.playerRacket?.physicsBody?.velocity.dx = dxVelocity! + CGFloat(XForce)
        
        //"lock" the ship on the game area
        
        if (playerRacket?.position.x)! > self.frame.maxX - ((playerRacket?.size.width)!/2){
            playerRacket?.position.x = self.frame.maxX - ((playerRacket?.size.width)!/2)
        }
        if (playerRacket?.position.x)! < self.frame.minX + ((playerRacket?.size.width)!/2){
            playerRacket?.position.x = self.frame.minX + ((playerRacket?.size.width)!/2)
        }
        
        
    }
    

    
}
