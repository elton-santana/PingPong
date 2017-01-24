//
//  Facade.swift
//  PingPong
//
//  Created by Elton Santana on 06/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
import Tibei

class Facade {
    static let shared = Facade()

    
    let serviceIdentifier = "_pingPong"
    let localSender = UIDevice.current.name
    var server: ServerMessenger
    var connection: ConnectionID?
    var client: ClientMessenger
    
    
    private init() {
        self.client = ClientMessenger()
        self.server = ServerMessenger(serviceIdentifier: self.serviceIdentifier)
    }
    
    
    func browseForServices(){
        self.client.browseForServices(withIdentifier: self.serviceIdentifier)
    }
    
    func registerClientResponder(_ responder: ConnectionResponder){
        self.client.registerResponder(responder)
    }
    
    func unregisterClientResponder(_ responder: ConnectionResponder){
        self.client.unregisterResponder(responder)
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
        self.server.publishService()
    }
    
    func registerServerResponder(_ responder: ConnectionResponder){
        self.server.registerResponder(responder)
    }
    
    func unregisterServerResponder(_ responder: ConnectionResponder){
        self.server.unregisterResponder(responder)
    }
    
    func registerServerConnectionID(_ id: ConnectionID){
        self.connection = id
    }
    
    func sendMessage<Message: JSONConvertibleMessage>(_ message: Message){
        guard self.connection == nil else {
            do {
                try  self.server.sendMessage(message, toConnectionWithID: self.connection!)
                
            } catch {
                print("Error trying to send message:")
                print(error)
            }
            return
        }
        
        
        do {
            try self.client.sendMessage(message)
        } catch{
            print("Error trying to send message:")
            print(error)
        }
     
        
    }
    
    func closeConnection(){
        if self.localPlayerIsAtHome(){
            self.server.unpublishService()
        }else{
            self.client.disconnect()
        }
        self.connection = nil
        self.currentMatch = nil
    }
    
    
    //MARK: Match related code
    
    var currentMatch: Match?
    
    func initializeMatch(with opponent: String, atHome: Bool){
        self.currentMatch = Match(withOpponentName: opponent, atHome: atHome)
    }
    func getLocalPlayerName() -> String{
        return (self.currentMatch?.getLocalPlayerName())!
    }
    func getOpponentPlayerName() -> String{
        return (self.currentMatch?.getOpponentName())!
    }
    func changeLocalPlayerStatus(to status: Bool){
        self.currentMatch?.localPlayer.isReady = status
    }
    func changeOpponentPlayerStatus(to status: Bool){
        self.currentMatch?.opponentPlayer.isReady = status
    }
    func areBothPlayersReady() -> Bool{
        return (self.currentMatch?.areBothPlayersReady())!
    }
    func localPlayerIsAtHome()-> Bool{
        return (self.currentMatch?.localPlayerIsPlayerAtHome)!
    }
    func localPlayerDidScore(){
        self.currentMatch?.localPlayer.improveScore()
    }
    func opponentPlayerDidScore(){
        self.currentMatch?.opponentPlayer.improveScore()
    }
    func getLocalPlayerScore()-> Int{
        return (self.currentMatch?.localPlayer.score)!
    }
    func getOpponentPlayerScore()-> Int{
        return (self.currentMatch?.opponentPlayer.score)!
    }
    func getPlayerWithBestScoreName() -> String{
        return (self.currentMatch?.getPlayerWithTheBestScoreName())!
    }
    
    
    
}
