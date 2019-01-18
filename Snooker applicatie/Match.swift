//
//  Match.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 18/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import ObjectMapper

class Match: Mappable {
    
    //properties
    var matchId: Int? = 0
    var potSucces: Int? = 0
    var player: String? = ""
    var opponent: String? = ""
    var safetySucces: Int? = 0
    var durationMatch: String? = ""
    var dateOfMatch: String? = ""
    var numberOfMatchesWonPlayer1: Int? = 0
    var numberOfMatchesWonPlayer2: Int? = 0
    var opslaanBreak: Int? = 0
    var userId: String? = ""
    var frames: [Frame]?
    
    func mapping(map: Map) {
        matchId <- map["MatchId"]
        potSucces <- map["PotSucces"]
        player <- map["Player"]
        opponent <- map["Opponent"]
        safetySucces <- map["SafetySucces"]
        durationMatch <- map["DurationMatch"]
        dateOfMatch <- map["DateOfMatch"]
        numberOfMatchesWonPlayer1 <- map["NumberMatchesWonPlayer1"]
        numberOfMatchesWonPlayer2 <- map["NumberMatchesWonPlayer2"]
        opslaanBreak <- map["OpslaanBreak"]
        userId <- map["UserId"]
        frames <- map["Frames"]
    }
    
    required init?(map: Map) {
        
    }
    
}
