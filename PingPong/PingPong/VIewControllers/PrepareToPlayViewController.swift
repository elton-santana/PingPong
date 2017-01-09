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

    override func viewDidLoad() {
        super.viewDidLoad()

        Facade.shared.registerClientResponder(self)
        Facade.shared.registerServerResponder(self)
        
        self.playWithLabel.text = Facade.shared.getOpponentName()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        Facade.shared.changeLocalPlayerStatus(to: true)
        Facade.shared.sendMessage(StatusMessage(content: true))
        sender.isHidden = true
        self.checkPlayersStatus()
    }
    
    func checkPlayersStatus(){
        if Facade.shared.areBothPlayersReady(){
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "PrepareToPlayToGameSegue", sender: self)
            }
        }
        
        
    }
    
//    func updatePlayerStatus(to status: Bool){
//        switch status {
//        case true:
//            print("estou pronto")
//            Facade.shared.
//        default:
//            break
//        }
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PrepareToPlayViewController: ConnectionResponder {
    var allowedMessages: [JSONConvertibleMessage.Type] {
        return [TextMessage.self, PingMessage.self, StatusMessage.self]
    }
    
    func processMessage(_ message: JSONConvertibleMessage, fromConnectionWithID connectionID: ConnectionID) {
        
        switch message {
        case let textMessage as TextMessage:
            print(textMessage.sender)
            print(textMessage.content)
            
            
        case let statusMessage as StatusMessage:
            Facade.shared.changeOpponentStatus(to: statusMessage.content)
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

