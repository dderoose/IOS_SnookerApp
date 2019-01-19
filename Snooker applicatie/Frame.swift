//
//  Frame.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 18/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import ObjectMapper

//This is a Model class for a Frame with his values
class Frame: Mappable {
    
    //properties
    var frameId: Int? = 0
    var durationMatch: Int? = 0
    var pointsWinner: Int? = 0
    var pointsOpponent: Int? = 0
    var winner: String? = ""
    var matchId: Int? = 0
    var breaks: [Breaks]?
    
    //This is a map function to map the values from the api call
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
