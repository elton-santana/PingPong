//
//  NavigationViewController.swift
//  PingPong
//
//  Created by Elton Santana on 04/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import UIKit

protocol NavigationDelegate {
    func changeScreenTo(_ screenName: String)
}

class NavigationViewController: UIViewController, NavigationDelegate {
    
    var screenView : Screen?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let allViewsInXibArray = Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)
        
        screenView = allViewsInXibArray?.first as! HomeView
        
        if let screen = screenView{
            screen.navigation = self
            screen.frame.size = self.view.frame.size
            self.view.addSubview(screen)
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeScreenTo(_ screenName: String){
        
//        let allViewsInXibArray = Bundle.main.loadNibNamed("WaitingConnectionView", owner: self, options: nil)
//        
//        screenView = allViewsInXibArray?.first as! WaitingConnectionView
//        
//        if let screen = screenView{
//            screen.navigation = self
//            screen.frame.size = self.view.frame.size
////            self.view.addSubview(screen)
//        }
//
//        
////        UIView.animate(withDuration: 1, animations: {
////            
////            self.screenView?.alpha = 0
////            
////        }) { (true) in
////            UIView.animate(withDuration: 0, animations: {
////                
////                let allViewsInXibArray = Bundle.main.loadNibNamed("WaitingConnectionView", owner: self, options: nil)
////                
////                self.screenView = allViewsInXibArray?.first as! WaitingConnectionView
////                
////            }, completion: { (true) in
////                
////                UIView.animate(withDuration: 1, animations: { 
////                    
////                    self.screenView?.alpha = 1
////                    
////                })
////                
////            })
////        }
        
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
