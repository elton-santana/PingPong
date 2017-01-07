//
//  ChooseConnectionViewController.swift
//  PingPong
//
//  Created by Elton Santana on 05/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import UIKit
import Tibei


class ChooseConnectionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Facade.shared.registerClientResponder(self)
        Facade.shared.browseForServices()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ChooseConnectionViewController: ClientConnectionResponder {
    func availableServicesChanged(availableServiceIDs: [String]) {
        
        do {
//            try self.client.connect(serviceName: availableServiceIDs.first!)
        } catch {
            print("An error occurred while trying to connect")
            print(error)
        }
    }
    
    func acceptedConnection(withID connectionID: ConnectionID) {
//        self.sendMessageButton.isEnabled = true
//        self.pingButton.isEnabled = true
    }
}
