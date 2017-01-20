//
//  GameViewController.swift
//  PingPong
//
//  Created by Elton Santana on 28/12/16.
//  Copyright © 2016 Back St Eltons. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Tibei

class GameViewController: UIViewController {
    
    var gameDelegate: GameDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                self.gameDelegate = sceneNode
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .fill
                
//                TODO: - Ajustar o size pra não rolar um muito maior que o outro
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Facade.shared.localPlayerIsAtHome(){
            Facade.shared.registerServerResponder(self)
        }else{
            Facade.shared.registerClientResponder(self)
        }
    }
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}


extension GameViewController: ConnectionResponder {
    var allowedMessages: [JSONConvertibleMessage.Type] {
        return [TextMessage.self, PingMessage.self, BallMessage.self, ScoreMessage.self]
    }
    
    func processMessage(_ message: JSONConvertibleMessage, fromConnectionWithID connectionID: ConnectionID) {
        
        switch message {
        case let ballMessage as BallMessage:
            self.gameDelegate?.fireBall(withInitialX: ballMessage.coord,
                          andVelocity: CGVector(dx: ballMessage.velocityDx,
                                                dy: ballMessage.velocityDy))
            print("//////////////////////////")
            print("did process a ball message")
            print("//////////////////////////")
        case _ as ScoreMessage:
            self.gameDelegate?.updateLocalScore()
            print("///////////////////////////")
            print("did process a score message")
            print("///////////////////////////")
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
