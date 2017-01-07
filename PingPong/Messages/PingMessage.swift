//
//  PingPong.swift
//  PingPong
//
//  Created by Elton Santana on 06/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Tibei

class PingMessage: JSONConvertibleMessage {
    var sender: String
    
    init(sender: String) {
        self.sender = sender
    }
    
    required init(jsonObject: [String : Any]) {
        self.sender = jsonObject["sender"] as! String
    }
    
    func toJSONObject() -> [String : Any] {
        return [
            "sender": self.sender
        ]
    }
}
