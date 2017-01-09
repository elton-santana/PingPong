//
//  WaitingPlayerViewController.swift
//  PingPong
//
//  Created by Elton Santana on 05/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import UIKit
import Tibei

class WaitingPlayerViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Facade.shared.publishServer()
        Facade.shared.registerServerResponder(self)
        
    }
    
}

extension WaitingPlayerViewController: ConnectionResponder {
    var allowedMessages: [JSONConvertibleMessage.Type] {
        return [TextMessage.self, PingMessage.self]
    }
    
    func processMessage(_ message: JSONConvertibleMessage, fromConnectionWithID connectionID: ConnectionID) {
        
        switch message {
        case let textMessage as TextMessage:
                print(textMessage.sender)
                print(textMessage.content)
       
            
        case let pingMessage as PingMessage:
            print(pingMessage.sender)
            Facade.shared.initializeMatch(with: pingMessage.sender, atHome: true)
            Facade.shared.sendMessage(PingMessage(sender: UIDevice.current.name))
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "WaitingPlayerToPrepareToPlaySegue", sender: self)
            }
            
        default:
            break
        }
    }
    
    func acceptedConnection(withID connectionID: ConnectionID) {
        Facade.shared.registerServerConnectionID(connectionID)
        
    }
    
    func lostConnection(withID connectionID: ConnectionID) {
        let rawContent: String = "Lost connection with id #\(connectionID.hashValue)"
        print(rawContent)
    }
    
    func processError(_ error: Error, fromConnectionWithID connectionID: ConnectionID?) {
        print("Error raised from connection #\(connectionID?.hashValue):")
        print(error)
    }

}
