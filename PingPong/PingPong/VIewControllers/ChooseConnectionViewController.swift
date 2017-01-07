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
    
    var availableServices: [String] = ["Elton", "Oscar"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.servicesTableView.dataSource = self
        self.servicesTableView.delegate = self

        Facade.shared.browseForServices()
        Facade.shared.registerClientResponder(self)

        
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
        
        self.availableServices = availableServiceIDs
        DispatchQueue.main.async {
            self.servicesTableView.reloadData()
        }
    }
    
    func acceptedConnection(withID connectionID: ConnectionID) {
//        self.sendMessageButton.isEnabled = true
//        self.pingButton.isEnabled = true
    }
}
