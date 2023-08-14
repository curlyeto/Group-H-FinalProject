//
//  Player.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-13.
//

//Player
//
//Player_id:Int
//Score:Int
//Username:String
//Rank:Int
//Avatar:String
//Title:String
//win_code:Int
//loss_count:Int
//draw_count:Int

import Foundation
class Player :Decodable{
    var player_id: Int
    var url: String
    var username: String
    var score: Int
    var rank: Int
    var country: String
    var title: String?
    var status: String
    var avatar: String
    var trend_score: Trend
    var trend_rank: Trend
    var flair_code: String
    var win_count: Int
    var loss_count: Int
    var draw_count: Int
    
    init(player_id: Int, url: String, username: String, score: Int, rank: Int, country: String, title: String, status: String, avatar: String, trend_score: Trend, trend_rank: Trend, flair_code: String, win_count: Int, loss_count: Int, draw_count: Int) {
        self.player_id = player_id
        self.url = url
        self.username = username
        self.score = score
        self.rank = rank
        self.country = country
        self.title = title
        self.status = status
        self.avatar = avatar
        self.trend_score = trend_score
        self.trend_rank = trend_rank
        self.flair_code = flair_code
        self.win_count = win_count
        self.loss_count = loss_count
        self.draw_count = draw_count
    }
}
