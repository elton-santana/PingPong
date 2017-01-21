//
//  GameDelegate.swift
//  PingPong
//
//  Created by Elton Santana on 20/01/17.
//  Copyright © 2017 Back St Eltons. All rights reserved.
//

import Foundation
import UIKit

protocol GameDelegate {
    
    func fireBall(withInitialX coord: CGFloat, andVelocity velocity: CGVector)
    func updateLocalScore()
}
