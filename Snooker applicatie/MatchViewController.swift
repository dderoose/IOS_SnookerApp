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
    var player: String!
    var bestOf: Int!
    var saveBreak: Int!
    var playedFrames: Int!
    var dateOfMatch: String!

    @IBOutlet weak var btnAddScorePlayer1: UIButton!
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    @IBOutlet weak var lblFramesPlayed: UILabel!
    @IBOutlet weak var btnAddScorePlayer2: UIButton!
    @IBOutlet weak var btnEndFrame: UIButton!
    @IBOutlet weak var btnEndMatch: UIButton!
    @IBAction func btnEndMatchTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "endMatchSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btnEndFrame.backgroundColor = UIColor.gray
        btnEndFrame.layer.borderColor = UIColor.lightGray.cgColor
        btnEndFrame.layer.cornerRadius = 5
        btnEndFrame.layer.borderWidth = 1
        btnEndMatch.backgroundColor = UIColor.gray
        btnEndMatch.layer.borderColor = UIColor.lightGray.cgColor
        btnEndMatch.layer.cornerRadius = 5
        btnEndMatch.layer.borderWidth = 1
        btnAddScorePlayer1.backgroundColor = UIColor.gray
        btnAddScorePlayer1.layer.borderColor = UIColor.lightGray.cgColor
        btnAddScorePlayer1.layer.cornerRadius = 5
        btnAddScorePlayer1.layer.borderWidth = 1
        btnAddScorePlayer2.backgroundColor = UIColor.gray
        btnAddScorePlayer2.layer.borderColor = UIColor.lightGray.cgColor
        btnAddScorePlayer2.layer.cornerRadius = 5
        btnAddScorePlayer2.layer.borderWidth = 1
        lblPlayer1.text = player
        lblPlayer2.text = opponent
        lblFramesPlayed.numberOfLines = 0
        lblFramesPlayed.text = "Aantal gespeelde frames:"+String(playedFrames)+"/"+String(bestOf)
        self.navigationItem.setHidesBackButton(true, animated:true);
        btnEndFrame.addTarget(self, action: #selector(matchScreen(sender:)), for: .touchUpInside)
    }
    
    @objc func matchScreen(sender: UIButton!){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let matchViewController = segue.destination as? MatchViewController else { return }
        matchViewController.matchId = matchId
        matchViewController.opponent = opponent
        matchViewController.bestOf = bestOf
        matchViewController.saveBreak = saveBreak
        matchViewController.playedFrames = playedFrames+1
        matchViewController.dateOfMatch = dateOfMatch
        matchViewController.player = player
    }
}
