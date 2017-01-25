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
        if (contact.bodyA.categoryBitMask <= contact.bodyB.categoryBitMask) {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        }
        else{
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        if firstBody.categoryBitMask == PhysicsCategory.ball &&
            secondBody.categoryBitMask == PhysicsCategory.sideBar {
            
            let ball = firstBody.node as! SKSpriteNode
            let ballVelocity = ball.physicsBody?.velocity
            ball.physicsBody?.velocity.dx = -(ballVelocity?.dx)!
        }
        if firstBody.categoryBitMask == PhysicsCategory.ball &&
           secondBody.categoryBitMask == PhysicsCategory.racket {
            
            let ball = firstBody.node as! SKSpriteNode
            let racket = secondBody.node as! SKSpriteNode
            
            let ballVelocity = ball.physicsBody?.velocity
            let racketVelocityDx = racket.physicsBody?.velocity.dx
            
            ball.physicsBody?.velocity.dy = -ballVelocity!.dy + (0.7)*(racketVelocityDx)!
            ball.physicsBody?.velocity.dx = ballVelocity!.dx + (0.4)*(racketVelocityDx)!
        }
        if firstBody.categoryBitMask == PhysicsCategory.ball &&
            secondBody.categoryBitMask == PhysicsCategory.transferSensor {
            
            let ball = firstBody.node as! SKSpriteNode
            let ballVelocity = ball.physicsBody?.velocity
            let normalizedCoord = ball.position.x/self.size.width/2
            ball.isHidden = true
            Facade.shared.sendMessage(BallMessage(coord: normalizedCoord, velocity: ballVelocity!))
        }
        if firstBody.categoryBitMask == PhysicsCategory.ball &&
            secondBody.categoryBitMask == PhysicsCategory.goalSensor {
            
            let ball = firstBody.node as! SKSpriteNode
            ball.isHidden = true
            Facade.shared.opponentPlayerDidScore()
            Facade.shared.sendMessage(ScoreMessage())
            self.updateScoreLabels()
            if self.gameIsOver(){
                self.finishGame()
            }
        }
        
    }

}

