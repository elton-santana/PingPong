//
//  PrepareToPlayViewController.swift
//  PingPong
//
//  Created by Elton Santana on 05/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import UIKit
import Tibei

class PrepareToPlayViewController: UIViewController {
    
    @IBOutlet weak var playWithLabel: UILabel!

    @IBOutlet weak var waitingLabel: UILabel!
    @IBOutlet weak var waitingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        if Facade.shared.localDeviceIsServer!{
            Facade.shared.registerServerResponder(self)
            Facade.shared.unpublishServer()
        }else{
            Facade.shared.registerClientResponder(self)
        }
        
        DispatchQueue.main.async {
            self.playWithLabel.text = "You will play with \(Facade.shared.getOpponentPlayerName())"
        }
        
    }
    
    
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        Facade.shared.changeLocalPlayerStatus(to: true)
        Facade.shared.sendMessage(StatusMessage(content: true))
        sender.isHidden = true
        self.checkPlayersStatus()
        self.waitingLabel.isHidden = false
        self.waitingIndicator.isHidden = false
    }
    
    func checkPlayersStatus(){
        if Facade.shared.areBothPlayersReady(){
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "PrepareToPlayToGameSegue", sender: self)
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        if Facade.shared.localDeviceIsServer!{
            Facade.shared.unregisterServerResponder(self)
        }else{
            Facade.shared.unregisterClientResponder(self)
        }
    }
    
}

//MARK: Connection extension


extension PrepareToPlayViewController: ConnectionResponder {
    var allowedMessages: [JSONConvertibleMessage.Type] {
        return [StatusMessage.self]
    }
    
    func processMessage(_ message: JSONConvertibleMessage, fromConnectionWithID connectionID: ConnectionID) {
        
        switch message {
        case let statusMessage as StatusMessage:
            Facade.shared.changeOpponentPlayerStatus(to: statusMessage.content)
            self.checkPlayersStatus()
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

