//
//  DoubleMessage.swift
//  PingPong
//
//  Created by Elton Santana on 07/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Tibei

class CoordMessage: JSONConvertibleMessage {
    var content: Double
    
    init(content: Double) {
        self.content = content
    }
    
    required init(jsonObject: [String : Any]) {
        self.content = jsonObject["content"] as! Double
    }
    
    func toJSONObject() -> [String : Any] {
        return [
            "content": self.content
        ]
    }
}
