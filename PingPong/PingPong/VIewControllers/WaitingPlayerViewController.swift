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
            let labelContent = NSMutableAttributedString(string: "\(textMessage.sender): \(textMessage.content)")
            
            labelContent.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleDouble.rawValue, range: NSMakeRange(0, textMessage.sender.characters.count + 1))
       
            
        case let pingMessage as PingMessage:
                print(pingMessage.sender)
            
        default:
            break
        }
    }
    
    func acceptedConnection(withID connectionID: ConnectionID) {
        let rawContent: String = "New connection with id #\(connectionID.hashValue)"
        let labelContent = NSMutableAttributedString(string: rawContent)
        
        labelContent.addAttribute(NSForegroundColorAttributeName, value: UIColor.purple, range: NSMakeRange(0, rawContent.characters.count))
        
        DispatchQueue.main.async {
//            self.incomingMessageLabel.attributedText = labelContent
        }
    }
    
    func lostConnection(withID connectionID: ConnectionID) {
        let rawContent: String = "Lost connection with id #\(connectionID.hashValue)"
        let labelContent = NSMutableAttributedString(string: rawContent)
        
        labelContent.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(0, rawContent.characters.count))
        
        DispatchQueue.main.async {
//            self.incomingMessageLabel.attributedText = labelContent
        }
    }
    
    func processError(_ error: Error, fromConnectionWithID connectionID: ConnectionID?) {
        print("Error raised from connection #\(connectionID?.hashValue):")
        print(error)
    }

}
