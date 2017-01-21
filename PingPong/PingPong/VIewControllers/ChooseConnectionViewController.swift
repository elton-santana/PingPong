//
//  ChooseConnectionViewController.swift
//  PingPong
//
//  Created by Elton Santana on 05/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import UIKit
import Tibei


class ChooseConnectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
 {
    
    @IBOutlet weak var servicesTableView: UITableView!
    
    var availableServices: [String] = ["Browsing Available Matchs"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.servicesTableView.dataSource = self
        self.servicesTableView.delegate = self
        
        Facade.shared.registerClientResponder(self)
        Facade.shared.browseForServices()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableView methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.availableServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = servicesTableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = self.availableServices[row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        self.confirmConnect(with: self.availableServices[row])
        
    }
    
    func confirmConnect(with player: String){
        
        let popUp = UIAlertController(title: "Play with \(player)?", message: "", preferredStyle: .alert)
        
        let dontConnectAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
        popUp.addAction(dontConnectAction)
        
        let connectAction = UIAlertAction(title: "Yes", style: .default) { (startMatchAction) in
            Facade.shared.connect(serviceName: player)
        }
        popUp.addAction(connectAction)
        
        self.present(popUp, animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Facade.shared.unregisterClientResponder(self)
    }
    
}


extension ChooseConnectionViewController: ClientConnectionResponder {
    var allowedMessages: [JSONConvertibleMessage.Type] {
        return [PingMessage.self]
    }
    
    func processMessage(_ message: JSONConvertibleMessage, fromConnectionWithID connectionID: ConnectionID) {
        
        switch message {
        case let pingMessage as PingMessage:
            Facade.shared.initializeMatch(with: pingMessage.sender, atHome: false)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "ChooseConnectionToPrepareToPlaySegue", sender: self)
            }
            
            print(pingMessage.sender)
            
        default:
            break
        }
    }

    func availableServicesChanged(availableServiceIDs: [String]) {
        
        self.availableServices = availableServiceIDs
        DispatchQueue.main.async {
            self.servicesTableView.reloadData()
        }
    }
    
    func acceptedConnection(withID connectionID: ConnectionID) {
        Facade.shared.sendMessage(PingMessage(sender: UIDevice.current.name))

    }
}
