//
//  ViewMatchController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 15/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import JWTDecode

class ViewMatchController: UITableViewController{
    
    @IBOutlet var tableMatchView: UITableView!
    var arrayMatches: [AnyObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableMatchView.rowHeight = 60.0
        
        //print(Constants.token)
        let jwt = try! decode(jwt: Constants.token)
        let name = jwt.claim(name: "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier")
        var id = ""
        if let idUser = name.string {
            id = idUser
        }
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Matches/userid/\(id)").responseData { response in
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                let data: NSData = utf8Text.data(using: String.Encoding.utf8)! as NSData
                var _: NSError?
                
                do {
                    let jsonResult : AnyObject? = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as AnyObject
                    let matchListArray = (jsonResult as! NSArray) as Array
                    self.arrayMatches = matchListArray
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMatches.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MatchTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MatchTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MatchTableViewCell.")
        }        // Fetches the appropriate meal for the data source layout.
        let matches = self.arrayMatches[indexPath.row] as! NSDictionary
        
        cell.playersOfMatch.text = (matches["Player"] as! String) + " tegen " + (matches["Opponent"] as! String)
        
        let numberLetters = (matches["DateOfMatch"] as! String).count
        let dateFormatter = DateFormatter()
        if(numberLetters == 19){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: matches["DateOfMatch"] as! String)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateOfMatch.text = dateFormatter.string(from: date)
        } else if(numberLetters == 23) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: matches["DateOfMatch"] as! String)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateOfMatch.text = dateFormatter.string(from: date)
        } else if(numberLetters == 22){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: matches["DateOfMatch"] as! String)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateOfMatch.text = dateFormatter.string(from: date)
        } else if(numberLetters == 21){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: matches["DateOfMatch"] as! String)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateOfMatch.text = dateFormatter.string(from: date)
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: matches["DateOfMatch"] as! String)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateOfMatch.text = dateFormatter.string(from: date)
        }
        
        cell.lblResult.text = "Uitslag"
        cell.lblResultMatch.text = String(matches["NumberMatchesWonPlayer1"] as! Int)  + ":" + String(matches["NumberMatchesWonPlayer2"] as! Int)
        matchId = matches["MatchId"] as! Int
        player1 = (matches["Player"] as! String)
        opponent = (matches["Opponent"] as! String)
        framesWonPlayer1 = (matches["NumberMatchesWonPlayer1"] as! Int)
        framesWonPlayer2 = (matches["NumberMatchesWonPlayer2"] as! Int)
        saveBreak = (matches["OpslaanBreak"] as! Int)
        cell.btnMatchstatistic.tag = indexPath.row
        cell.btnMatchstatistic.addTarget(self, action: #selector(nextScreen(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    var matchId: Int = 0
    var player1: String! = ""
    var opponent: String! = ""
    var framesWonPlayer1: Int! = 0
    var framesWonPlayer2: Int! = 0
    var saveBreak: Int! = 0
    @objc func nextScreen(sender: UIButton!){
        self.performSegue(withIdentifier: "matchStatisticSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let matchStatisticViewController = segue.destination as? MatchStatisticViewController else { return }
        matchStatisticViewController.matchId = matchId
        matchStatisticViewController.player1 = player1
        matchStatisticViewController.opponent = opponent
        matchStatisticViewController.framesWonPlayer1 = framesWonPlayer1
        matchStatisticViewController.framesWonPlayer2 = framesWonPlayer2
        matchStatisticViewController.saveBreak = saveBreak
    }
}

