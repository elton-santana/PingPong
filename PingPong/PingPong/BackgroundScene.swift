//
//  BackgroundScene.swift
//  PingPong
//
//  Created by Elton Santana on 16/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
import SpriteKit

class BackgroundScene: SKScene, SKPhysicsContactDelegate {
    
    var leftSideRacket: SKSpriteNode?
    var rightSideRacket: SKSpriteNode?
    var ball: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        self.initializeInterfaceVariables()
        self.startAnimation()
        
    }
    
    func initializeInterfaceVariables(){
        self.leftSideRacket = self.childNode(withName: "LeftRacketNode") as? SKSpriteNode
        self.rightSideRacket = self.childNode(withName: "RightRacketNode") as? SKSpriteNode
        self.ball = self.childNode(withName: "BallNode") as? SKSpriteNode
    }
    func startAnimation(){
        self.fireBall()
        self.racketFollow()
    }
    
    func fireBall(){
        self.ball?.physicsBody?.velocity = CGVector(dx: 250, dy: 250)
    }
    
    func racketFollow(){
        self.leftSideRacket?.physicsBody?.velocity.dy = (self.ball?.physicsBody?.velocity.dy)!
        self.rightSideRacket?.physicsBody?.velocity.dy = (self.ball?.physicsBody?.velocity.dy)!
    }
    
    
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
            ball.physicsBody?.velocity.dy = -(ballVelocity?.dy)!
            self.racketFollow()
        }
        
        if firstBody.categoryBitMask == PhysicsCategory.ball &&
            secondBody.categoryBitMask == PhysicsCategory.racket {
            
            let ball = firstBody.node as! SKSpriteNode
            let ballVelocity = ball.physicsBody?.velocity
            ball.physicsBody?.velocity.dx = -(ballVelocity?.dx)!
        }
    }
}
