//
//  TutorialViewController.swift
//  PingPong
//
//  Created by Elton Santana on 25/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnButtonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "UnwindSegueHomeSegue", sender: self)
    }

}
