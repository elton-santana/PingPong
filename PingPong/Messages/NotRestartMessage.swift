//
//  NotRestartMessage.swift
//  PingPong
//
//  Created by Elton Santana on 25/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
import Tibei

class NotRestartMessage: JSONConvertibleMessage {
    
    init() {
        
    }
    
    required init(jsonObject: [String : Any]) {
        
    }
    
    func toJSONObject() -> [String : Any] {
        return [:]
    }
}
