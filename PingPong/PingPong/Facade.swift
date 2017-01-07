//
//  Facade.swift
//  PingPong
//
//  Created by Elton Santana on 06/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
import Tibei

class Facade: NSObject{
    static let shared = Facade()
    private override init() {
        super.init()
        
    }
    
    let serviceIdentifier = "_pingPong"
    var server: ServerMessenger?
    let client = ClientMessenger()
    
    func browseForServices(){
        self.client.browseForServices(withIdentifier: self.serviceIdentifier)
    }
    
    func registerClientResponder(_ responder: ConnectionResponder){
        self.client.registerResponder(responder)
    }
    
    func connect(serviceName: String){
        do {
            try self.client.connect(serviceName: serviceName)
        } catch {
            print("An error occurred while trying to connect")
            print(error)

    }
    
    }
    
    func publishServer(){
        self.server = ServerMessenger(serviceIdentifier: serviceIdentifier)
    }
    
    func registerServerResponder(_ responder: ConnectionResponder){
        self.server?.registerResponder(responder)
    }
    
    
}
