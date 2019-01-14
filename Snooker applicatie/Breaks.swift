//
//  Break.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 14/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
class Breaks: NSObject {
    
    //properties
    var breakId: Int? = 0
    var player: String? = ""
    var momentPlayed: String? = ""
    var numberPoints: Int? = 0
    var opponent: String? = ""
    var typeBreak: String? = ""
    var frameId: Int? = 0
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @username, @email, @password, and @confirmPassword parameters
    
    init(breakId:Int, player: String, momentPlayed: String, numberPoints: Int, opponent: String,typeBreak: String, frameId: Int?) {
        
        self.breakId = breakId
        self.player = player
        self.momentPlayed = momentPlayed
        self.numberPoints = numberPoints
        self.opponent = opponent
        self.typeBreak = typeBreak
        self.frameId = frameId
        
    }
}
