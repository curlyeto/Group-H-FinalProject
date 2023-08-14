//
//  ChessApiHelper.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-13.
//

import Foundation
import UIKit

enum DogAPI_Errors: Error {
    case cannotConvertURL
}

class ChessAPI_Helper{
    
    // Base URL string for the Dog API
    public static var baseURLString = "https://api.chess.com"
    
    // Fetches data from the specified URL string asynchronously
    public static func fetch(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw DogAPI_Errors.cannotConvertURL
        }
        
        // Uses URLSession.shared to fetch data from the URL
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
   
    public static func fetchLedearBoards() async throws -> PlayerResponse {
        let urlString = "\(baseURLString)/pub/leaderboards"
        let data = try await fetch(urlString: urlString)
        let decoder = JSONDecoder()
        let leaderboards = try decoder.decode(PlayerResponse.self, from: data)

        return leaderboards
    }
    
  
    
}
