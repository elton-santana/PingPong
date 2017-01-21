//
//  HomeViewController.swift
//  PingPong
//
//  Created by Elton Santana on 05/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presentSKView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToHomeSegue(_ sender: UIStoryboardSegue){
        
    }
    
    @IBAction func PlayButtonAction(_ sender: UIButton) {
        self.showConnectionPopUp()
    }
    
    func presentSKView(){
        
        if let scene = GKScene(fileNamed: "BackgroundScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! BackgroundScene? {
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .fill
                                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
//        if let view = self.view as! SKView? {
//
//            let scene = BackgroundScene(fileNamed:"BackgroundScene")
//            scene?.scaleMode = .aspectFill
//            view.presentScene(scene)
//            
//            view.ignoresSiblingOrder = true
//            view.showsPhysics = false
//            view.showsFPS = false
//            view.showsNodeCount = false
//        
//        }
    }
    
    func showConnectionPopUp(){
        
        let popUp = UIAlertController(title: "Choose how start to play", message: "", preferredStyle: .alert)
        
        let startMatchAction = UIAlertAction(title: "Open a new match", style: .default, handler: self.goToWaitingPlayer)
        popUp.addAction(startMatchAction)
        
        let joinAnExistingMatchAction = UIAlertAction(title: "Join an existing match", style: .default, handler: self.goToChooseConnection)
        popUp.addAction(joinAnExistingMatchAction)
        
        self.present(popUp, animated: true, completion: nil)
        
    }
    
    func goToWaitingPlayer(alert: UIAlertAction!){
        self.performSegue(withIdentifier: "HomeToWaitingPlayerSegue", sender: self)
    }
    
    func goToChooseConnection(alert: UIAlertAction!){
        self.performSegue(withIdentifier: "HomeToChooseConnectionSegue", sender: self)
    }


}
