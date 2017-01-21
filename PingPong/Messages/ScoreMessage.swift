//
//  GameMessage.swift
//  PingPong
//
//  Created by Elton Santana on 09/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
import Tibei

class ScoreMessage: JSONConvertibleMessage {

    init() {
        
    }
    
    required init(jsonObject: [String : Any]) {
        
    }
    
    func toJSONObject() -> [String : Any] {
        return [:]
    }
}
