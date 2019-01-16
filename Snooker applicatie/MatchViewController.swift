//
//  MatchViewController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 16/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import JWTDecode

class MatchViewController: UIViewController{
    var matchId: Int!
    var opponent: String!
    var bestOf: Int!
    var saveBreak: Int!
    var playedFrames: Int!
    var dateOfMatch: String!

    @IBAction func btnEndMatchTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "endMatchSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(matchId)
        print(opponent)
        print(bestOf)
        print(saveBreak)
        print(playedFrames)
        print(dateOfMatch)
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
}
