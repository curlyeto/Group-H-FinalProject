//
//  Trend.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-13.
//

import Foundation
class Trend :Decodable{
    var direction: Int
    var delta: Int
    
    init(direction: Int, delta: Int) {
        self.direction = direction
        self.delta = delta
    }
}
