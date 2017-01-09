//
//  Match.swift
//  PingPong
//
//  Created by Elton Santana on 07/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
import UIKit

class Match {
    
    let opponentPlayer: Player = Player()
    let localPlayer: Player = Player()
    var localPlayerIsPlayerAtHome: Bool = false
    
    init(withOpponentName opponent: String, atHome: Bool){
        self.opponentPlayer.name = opponent
        self.localPlayer.name = UIDevice.current.name
        self.localPlayerIsPlayerAtHome = atHome
    }
    
    func getLocalPlayerName()-> String{
        return self.localPlayer.name
    }
    func getOpponentName() -> String{
        return self.opponentPlayer.name
    }
    
    func areBothPlayersReady() -> Bool{
        return self.opponentPlayer.isReady && self.localPlayer.isReady
    }
    
}
