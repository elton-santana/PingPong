//
//  Extensions.swift
//  PingPong
//
//  Created by Elton Santana on 27/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
extension String {
    func formatIphoneName() -> String {
        let deviceName = self
        
        if deviceName.hasSuffix("'s iPhone") {
            return deviceName.replacingOccurrences(of: "'s iPhone", with: "")
        } else if deviceName.hasPrefix("iPhone de ") {
            return deviceName.replacingOccurrences(of: "iPhone de ", with: "")
        } else if deviceName.hasPrefix("iPod de ") {
            return deviceName.replacingOccurrences(of: "iPod de ", with: "")
        } else if deviceName.hasPrefix("'s iPad") {
            return deviceName.replacingOccurrences(of: "'s iPad", with: "")
        }
        return deviceName
    }
}
