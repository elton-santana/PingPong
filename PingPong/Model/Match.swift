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
    
    let opponent: Player = Player()
    let localPlayer: Player = Player()
    
    init(withOpponentName opponent: String){
        self.opponent.name = opponent
        self.localPlayer.name = UIDevice.current.name
    }
    
}
