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
    
    func moveRacketWithAccelerometer() {
        
        let yGForce = self.motionManager.accelerometerData!.acceleration.y

        let dxVelocity = self.playerRacket?.physicsBody?.velocity.dx
        
        self.playerRacket?.physicsBody?.velocity.dx = dxVelocity! - 100*CGFloat(yGForce)
        
        //"lock" the racket on the game area
        
        if (playerRacket?.position.x)! > self.frame.maxX - ((playerRacket?.size.width)!*(0.7)){
            playerRacket?.position.x = self.frame.maxX - ((playerRacket?.size.width)!*(0.7))
            self.playerRacket?.physicsBody?.velocity.dx = 0
        }
        if (playerRacket?.position.x)! < self.frame.minX + ((playerRacket?.size.width)!*(0.7)){
            playerRacket?.position.x = self.frame.minX + ((playerRacket?.size.width)!*(0.7))
            self.playerRacket?.physicsBody?.velocity.dx = 0
        }
    }
    
    func moveRacketWithGyroscope() {
        
        let gyroForce = self.motionManager.gyroData!.rotationRate.y
        
        let dxVelocity = self.playerRacket?.physicsBody?.velocity.dx
        
        if gyroForce > 1 || gyroForce < -1{
            self.playerRacket?.physicsBody?.velocity.dx = dxVelocity! + 90*CGFloat(gyroForce)
        }
        
        //"lock" the racket on the game area
        
        if (playerRacket?.position.x)! > self.frame.maxX - ((playerRacket?.size.width)!*(0.7)){
            playerRacket?.position.x = self.frame.maxX - ((playerRacket?.size.width)!*(0.7))
            self.playerRacket?.physicsBody?.velocity.dx = 0
        }
        if (playerRacket?.position.x)! < self.frame.minX + ((playerRacket?.size.width)!*(0.7)){
            playerRacket?.position.x = self.frame.minX + ((playerRacket?.size.width)!*(0.7))
            self.playerRacket?.physicsBody?.velocity.dx = 0
        }
    }

    
    
}
