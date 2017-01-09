//
//  ContactExtension.swift
//  PingPong
//
//  Created by Elton Santana on 09/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if (contact.bodyA.categoryBitMask >= contact.bodyB.categoryBitMask) {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        }
        else{
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        if firstBody.categoryBitMask == (self.ball?.physicsBody?.categoryBitMask)! &&
            secondBody.categoryBitMask == (self.rightSideBar?.physicsBody?.categoryBitMask)! {
            
            let ball = firstBody.node as! SKSpriteNode
            let ballVelocity = ball.physicsBody?.velocity
            ball.physicsBody?.velocity.dx = -(ballVelocity?.dx)!
        }
        if secondBody.categoryBitMask == (self.ball?.physicsBody?.categoryBitMask)! &&
           firstBody.categoryBitMask == (self.playerRacket?.physicsBody?.categoryBitMask)! {
            
            let ball = secondBody.node as! SKSpriteNode
            let ballVelocity = ball.physicsBody?.velocity
            ball.physicsBody?.velocity.dy = -(ballVelocity?.dy)!
        }
        
    }

}

