//
//  Frame.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 18/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import ObjectMapper


class Frame: Mappable {
    
    //properties
    var frameId: Int? = 0
    var durationMatch: Int? = 0
    var pointsWinner: Int? = 0
    var pointsOpponent: Int? = 0
    var winner: String? = ""
    var matchId: Int? = 0
    var breaks: [Breaks]?
    
    func mapping(map: Map) {
        frameId <- map["MatchId"]
        durationMatch <- map["DurationFrame"]
        pointsWinner <- map["PointsWinner"]
        pointsOpponent <- map["PointsOpponent"]
        winner <- map["Winner"]
        matchId <- map["MatchId"]
        breaks <- map["Breaks"]
    }
    
    required init?(map: Map) {
        
    }
    
}
