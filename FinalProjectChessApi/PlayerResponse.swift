//
//  PlayerResponse.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-13.
//

import Foundation
class PlayerResponse :Decodable {
    var daily: [Player]
    
    init(daily: [Player]) {
        self.daily = daily
    }
}
