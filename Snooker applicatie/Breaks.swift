//
//  Break.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 14/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import ObjectMapper

//This is a model class of a break with his values.
class Breaks: Mappable {
    
    //properties
    var breakId: Int? = 0
    var player: String? = ""
    var momentPlayed: String? = ""
    var numberPoints: Int? = 0
    var opponent: String? = ""
    var typeBreak: String? = ""
    var frameId: Int? = 0
    
    //this is to map the break when you do an api call
    func mapping(map: Map) {
        breakId <- map["BreakId"]
        player <- map["Player"]
        momentPlayed <- map["MomentPlayed"]
        numberPoints <- map["NumberPoints"]
        opponent <- map["Opponent"]
        typeBreak <- map["TypeBreak"]
        frameId <- map["FrameId"]
    }
    
    required init?(map: Map) {
        
    }
    
}
