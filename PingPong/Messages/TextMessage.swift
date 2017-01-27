//
//  TextMessage.swift
//  PingPong
//
//  Created by Elton Santana on 06/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Tibei

class TextMessage: JSONConvertibleMessage {
    var sender: String
    var content: String
    
    init(sender: String, content: String) {
        self.sender = sender
        self.content = content
    }
    
    required init(jsonObject: [String : Any]) {
        self.sender = jsonObject["sender"] as! String
        self.content = jsonObject["content"] as! String
    }
    
    func toJSONObject() -> [String : Any] {
        return [
            "sender": self.sender,
            "content": self.content
        ]
    }
}
