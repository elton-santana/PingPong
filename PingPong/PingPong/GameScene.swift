//
//  GameScene.swift
//  PingPong
//
//  Created by Elton Santana on 28/12/16.
//  Copyright © 2016 Back St Eltons. All rights reserved.
//

import SpriteKit
import GameplayKit
import Tibei

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    //MARK: - Nodes variables
    
    var leftSideBar: SKSpriteNode?
    var rightSideBar: SKSpriteNode?
    var playerRacket: SKSpriteNode?
    var ball: SKSpriteNode?
    
    
    
    private var lastUpdateTime : TimeInterval = 0

    
    override func sceneDidLoad() {
        
        self.physicsWorld.contactDelegate = self
        
//        self.lastUpdateTime = 0
        
        self.initializeNodesVariables()
        
    }
    func initializeNodesVariables(){
        self.leftSideBar = self.childNode(withName: "LeftSideBar") as? SKSpriteNode
        self.rightSideBar = self.childNode(withName: "RightSideBar") as? SKSpriteNode
        self.playerRacket = self.childNode(withName: "RacketNode") as? SKSpriteNode
        self.ball = self.childNode(withName: "BallNode") as? SKSpriteNode
        self.ball?.physicsBody?.contactTestBitMask = (self.playerRacket?.physicsBody?.categoryBitMask)! | (self.rightSideBar?.physicsBody?.categoryBitMask)!
    }
    
    func touchDown(atPoint pos : CGPoint) {
        self.playerRacket?.position.x = pos.x
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}

extension GameScene: ConnectionResponder {
    var allowedMessages: [JSONConvertibleMessage.Type] {
        return [TextMessage.self, PingMessage.self, CoordMessage.self, StatusMessage.self]
    }
    
    func processMessage(_ message: JSONConvertibleMessage, fromConnectionWithID connectionID: ConnectionID) {
        
        switch message {
        case let coordMessage as CoordMessage:
            print(coordMessage.content)
            
        case let textMessage as TextMessage:
            print(textMessage.sender)
            print(textMessage.content)
            
            
        case let pingMessage as PingMessage:
            print("recebeu um ping do \(pingMessage.sender)")
            
        default:
            break
        }
    }
    
    func acceptedConnection(withID connectionID: ConnectionID) {
    }
    
    func lostConnection(withID connectionID: ConnectionID) {
    }
    
    func processError(_ error: Error, fromConnectionWithID connectionID: ConnectionID?) {
        print("Error raised from connection #\(connectionID?.hashValue):")
        print(error)
    }
    
}




