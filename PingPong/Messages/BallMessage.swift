//
//  DoubleMessage.swift
//  PingPong
//
//  Created by Elton Santana on 07/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Tibei

class BallMessage: JSONConvertibleMessage {
    var coord: CGFloat
    var velocity: CGVector
    
    init(coord: CGFloat, velocity: CGVector) {
        self.coord = coord
        self.velocity = velocity
    }
    
    required init(jsonObject: [String : Any]) {
        self.coord = jsonObject["coord"] as! CGFloat
        self.velocity = jsonObject["velocity"] as! CGVector
    }
    
    func toJSONObject() -> [String : Any] {
        return [
            "coord": self.coord,
            "velocity": self.velocity
        ]
    }
}
