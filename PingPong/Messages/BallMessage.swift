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
    var velocityDx: CGFloat
    var velocityDy: CGFloat
    
    init(coord: CGFloat, velocity: CGVector) {
        self.coord = coord
        self.velocityDx = velocity.dx
        self.velocityDy = velocity.dy
    }
    
    required init(jsonObject: [String : Any]) {
        self.coord = jsonObject["coord"] as! CGFloat
        self.velocityDx = jsonObject["velocityDx"] as! CGFloat
        self.velocityDy = jsonObject["velocityDy"] as! CGFloat
    }
    
    func toJSONObject() -> [String : Any] {
        return [
            "coord": self.coord,
            "velocityDx": self.velocityDx,
            "velocityDy": self.velocityDy
        ]
    }
}
