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

struct PhysicsCategory {
    static let ball: UInt32 = 1
    static let sideBar: UInt32 = 2
    static let racket: UInt32 = 3
    static let goalSensor: UInt32 = 4
    static let transferSensor: UInt32 = 5
}
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    //MARK: - Nodes variables
    
    var leftSideBar: SKSpriteNode?
    var rightSideBar: SKSpriteNode?
    var playerRacket: SKSpriteNode?
    var ball: SKSpriteNode?
    
    var transferSensor: SKSpriteNode?
    var goalSensor: SKSpriteNode?
    
    var localPlayerScore: SKLabelNode?
    var localPlayerNameLabel: SKLabelNode?
    var opponentPlayerScore: SKLabelNode?
    var opponentPlayerNameLabel: SKLabelNode?
    
    
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
        
        self.goalSensor = self.childNode(withName: "GoalSensor") as? SKSpriteNode
        self.transferSensor = self.childNode(withName: "TransferSensor") as? SKSpriteNode
        
        self.localPlayerScore = self.childNode(withName: "LocalPlayerScore") as? SKLabelNode
        self.localPlayerNameLabel = self.childNode(withName: "LocalPlayerName") as? SKLabelNode
        self.opponentPlayerScore = self.childNode(withName: "OpponentPlayerScore") as? SKLabelNode
        self.opponentPlayerNameLabel = self.childNode(withName: "OpponentPlayerName") as? SKLabelNode
        
        self.setContactTestBitMask()
        self.setNameLabels()
        self.startGame()
    }
    
    func setContactTestBitMask(){
        guard self.ball == nil else {
            self.ball?.physicsBody?.contactTestBitMask = PhysicsCategory.racket |
                PhysicsCategory.sideBar |
                PhysicsCategory.goalSensor |
                PhysicsCategory.transferSensor
            return
        }
    }
    
    func setNameLabels(){
        self.localPlayerNameLabel?.text = Facade.shared.getLocalPlayerName()
        self.opponentPlayerNameLabel?.text = Facade.shared.getOpponentPlayerName()
    }
    
    func startGame(){
        if Facade.shared.localPlayerIsAtHome(){
            let velocity = CGVector(dx: 250, dy: -250)
            self.ball?.physicsBody?.velocity = velocity
        }else{
            self.ball?.removeFromParent()
        }
    }
    
    func updateScore(){
        Facade.shared.localPlayerDidScore()
        self.updateScoreLabels()
        self.restart()
        
    }
    
    func restart(){
        let velocity = CGVector(dx: 0, dy: -250)
        self.ball?.physicsBody?.velocity = velocity
        self.ball?.position = CGPoint.zero
        
        
    }
    func updateScoreLabels(){
        self.localPlayerScore?.text = String(Facade.shared.getLocalPlayerScore())
        self.opponentPlayerScore?.text = String(Facade.shared.getOpponentPlayerScore())
    }
    
    func fireBall(withInitialX coord: CGFloat, andVelocity velocity: CGVector){
        self.ball?.position = CGPoint(x: self.size.width/2 * coord, y: self.frame.maxY)
        self.ball?.physicsBody?.velocity = CGVector(dx: -velocity.dx, dy: -velocity.dy)
        self.addChild(self.ball!)

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
        return [TextMessage.self, PingMessage.self, BallMessage.self, ScoreMessage.self]
    }
    
    func processMessage(_ message: JSONConvertibleMessage, fromConnectionWithID connectionID: ConnectionID) {
        
        switch message {
        case let ballMessage as BallMessage:
            self.fireBall(withInitialX: ballMessage.coord, andVelocity: ballMessage.velocity)
            
        case let scoreMessage as ScoreMessage:
            self.updateScore()
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




