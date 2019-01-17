//
//  MatchStatisticViewController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 15/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import Alamofire

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Matches/\(matchId!)").responseData { response in
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                let data: NSData = utf8Text.data(using: String.Encoding.utf8)! as NSData
                var _: NSError?
                 do {
                 let jsonResult : AnyObject? = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as AnyObject
                    self.framesWonPlayer1 = (jsonResult!["NumberMatchesWonPlayer1"] as! Int)
                    self.framesWonPlayer2 = (jsonResult!["NumberMatchesWonPlayer2"] as! Int)
                    self.player1 = (jsonResult!["Player"] as! String)
                    self.opponent = (jsonResult!["Opponent"] as! String)
                    self.saveBreak = (jsonResult!["OpslaanBreak"] as! Int)
                    let totalFramesPlayed = self.framesWonPlayer1+self.framesWonPlayer2
                     self.lblPlayer1.numberOfLines = 0
                     self.lblPlayer2.numberOfLines = 0
                     self.lblNumberFramesPlayed.numberOfLines = 0
                     
                     self.lblPlayer1.text = self.player1!
                     self.lblPlayer2.text = self.opponent!
                     self.lblFramesWonPlayer1.text = String(self.framesWonPlayer1!)
                     self.lblFramesWonPlayer2.text = String(self.framesWonPlayer2!)
                     self.lblNumberFramesPlayed.text = "Frames: "+String(totalFramesPlayed)
                 } catch let error as NSError {
                 print(error.localizedDescription)
                 }
            }
        }
        
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Frames/matchid/\(matchId!)").responseData { response in
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                let data: NSData = utf8Text.data(using: String.Encoding.utf8)! as NSData
                var _: NSError?
                
                do {
                    let jsonResult : AnyObject? = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as AnyObject
                    let frameListArray = (jsonResult as! NSArray) as Array
                    self.arrayFrames = frameListArray
                    DispatchQueue.main.async {
                        self.tblViewFrame.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        tblViewFrame.delegate = self
        tblViewFrame.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayFrames.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FrameTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FrameTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BreaksTableViewCell.")
        }        // Fetches the appropriate meal for the data source layout.
        let frame = self.arrayFrames[indexPath.row] as! NSDictionary
        let arrayBreaks = (frame["Breaks"] as! NSArray) as Array
        var breaksPlayer1: String! = ""
        var breaksPlayer2: String! = ""
        for pointBreak in arrayBreaks {
            //if(breaks == ""){
            if((pointBreak["Player"] as! String) == player1) {
                if(breaksPlayer1 == ""){
                    breaksPlayer1 = breaksPlayer1+String(pointBreak["NumberPoints"] as! Int)
                } else {
                    breaksPlayer1 = breaksPlayer1+","+String(pointBreak["NumberPoints"] as! Int)
                }
            } else {
                if(breaksPlayer2 == ""){
                    breaksPlayer2 = breaksPlayer2+String(pointBreak["NumberPoints"] as! Int)
                } else {
                    breaksPlayer2 = breaksPlayer2+","+String(pointBreak["NumberPoints"] as! Int)
                }
            }
        }
        cell.lblPointsPlayer1.text = String(frame["PointsWinner"] as! Int)
        cell.lblPointsPlayer2.text = String(frame["PointsOpponent"] as! Int)
        cell.lblFrameNumber.text = String(indexPath.row+1)
        cell.lblBreaksPlayer1.text = breaksPlayer1!
        cell.lblBreaksPlayer2.text = breaksPlayer2!
        return cell
    }
    
    
}
