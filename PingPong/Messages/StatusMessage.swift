//
//  StatusMessage.swift
//  PingPong
//
//  Created by Elton Santana on 08/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Tibei

class StatusMessage: JSONConvertibleMessage {
    var content: Bool
    
    init(content: Bool) {
        self.content = content
    }
    
    required init(jsonObject: [String : Any]) {
        self.content = jsonObject["content"] as! Bool
    }
    
    func toJSONObject() -> [String : Any] {
        return [
            "content": self.content
        ]
    }
}
