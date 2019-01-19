//
//  MatchStatisticViewController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 15/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//


import Foundation
import UIKit
import Alamofire
import JWTDecode
import AlamofireObjectMapper


//This is the class to see the statistics of a match
class MatchStatisticViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var matchId: Int!
    var player1: String!
    var opponent: String!
    var framesWonPlayer1: Int!
    var framesWonPlayer2: Int!
    var saveBreak: Int!
    
    var arrayFrames: [AnyObject] = []
    
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    @IBOutlet weak var lblFramesWonPlayer1: UILabel!
    @IBOutlet weak var lblFramesWonPlayer2: UILabel!
    @IBOutlet weak var lblNumberFramesPlayed: UILabel!
    @IBOutlet weak var tblViewFrame: UITableView!
    
    //Here we do an api call to get all the data of the specific match
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Matches/\(matchId!)").responseObject { (response: DataResponse<Match>) in
            let match = response.result.value!
            self.framesWonPlayer1 = match.numberOfMatchesWonPlayer1
            self.framesWonPlayer2 = match.numberOfMatchesWonPlayer2
            self.player1 = match.player
            self.opponent = match.opponent
            self.saveBreak = match.opslaanBreak
            let totalFramesPlayed = self.framesWonPlayer1+self.framesWonPlayer2
            self.lblPlayer1.numberOfLines = 0
            self.lblPlayer2.numberOfLines = 0
            self.lblNumberFramesPlayed.numberOfLines = 0
            
            self.lblPlayer1.text = self.player1!
            self.lblPlayer2.text = self.opponent!
            self.lblFramesWonPlayer1.text = String(self.framesWonPlayer1!)
            self.lblFramesWonPlayer2.text = String(self.framesWonPlayer2!)
            self.lblNumberFramesPlayed.text = "Frames: "+String(totalFramesPlayed)
        }
        
        //Here we do an api call to get all the frames of a match
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Frames/matchid/\(matchId!)").responseArray { (response: DataResponse<[Frame]>) in
            
            self.arrayFrames = response.result.value!
            DispatchQueue.main.async {
                self.tblViewFrame.reloadData()
            }
        }
        tblViewFrame.delegate = self
        tblViewFrame.dataSource = self
    }
    
    //This is to set the numberOfSections in the tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //This is to know how much rows they need to be set in the tableview.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayFrames.count
    }
    
    //Here we fill in the cells of a tableview with values from the framearray
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FrameTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FrameTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BreaksTableViewCell.")
        }
        let frame = self.arrayFrames[indexPath.row] as! Frame
        let arrayBreaks = (frame.breaks)
        var breaksPlayer1: String! = ""
        var breaksPlayer2: String! = ""
        for pointBreak in arrayBreaks! {
            //if(breaks == ""){
            if(pointBreak.player! == player1) {
                if(breaksPlayer1 == ""){
                    breaksPlayer1 = breaksPlayer1+String(pointBreak.numberPoints!)
                } else {
                    breaksPlayer1 = breaksPlayer1+","+String(pointBreak.numberPoints!)
                }
            } else {
                if(breaksPlayer2 == ""){
                    breaksPlayer2 = breaksPlayer2+String(pointBreak.numberPoints!)
                } else {
                    breaksPlayer2 = breaksPlayer2+","+String(pointBreak.numberPoints!)
                }
            }
        }
        cell.lblPointsPlayer1.text = String(frame.pointsWinner!)
        cell.lblPointsPlayer2.text = String(frame.pointsOpponent!)
        cell.lblFrameNumber.text = String(indexPath.row+1)
        cell.lblBreaksPlayer1.text = breaksPlayer1!
        cell.lblBreaksPlayer2.text = breaksPlayer2!
        return cell
    }
    
    
}
