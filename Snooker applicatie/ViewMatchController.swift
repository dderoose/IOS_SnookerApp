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

//this is the view to see the matchtableview
class ViewMatchController: UITableViewController{
    
    @IBOutlet var tableMatchView: UITableView!
    var arrayMatches: [AnyObject] = []
    
    /* Here we decode the token to get the user his id
     We do also an api call to get all the matches from a specific user
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        tableMatchView.rowHeight = 60.0
        let jwt = try! decode(jwt: Constants.token)
        let name = jwt.claim(name: "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier")
        var id = ""
        if let idUser = name.string {
            id = idUser
        }
        
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Matches/userid/\(id)").responseArray { (response: DataResponse<[Match]>) in
            
            self.arrayMatches = response.result.value!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //This is to set the numberOfSections in the tableview
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //This is to know how much rows they need to be set in the tableview.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMatches.count
    }
    
    //Here we fill in the cells from a tableviewcell with values from the matcharray
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MatchTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MatchTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MatchTableViewCell.")
        }
        let match = self.arrayMatches[indexPath.row] as! Match
        
        cell.playersOfMatch.text = (match.player!) + " tegen " + (match.opponent!)
        
        let numberLetters = (match.dateOfMatch)!.count
        let dateFormatter = DateFormatter()
        if(numberLetters == 19){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: (match.dateOfMatch!))
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateOfMatch.text = dateFormatter.string(from: date!)
        } else if(numberLetters == 23) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: (match.dateOfMatch!))
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateOfMatch.text = dateFormatter.string(from: date!)
        } else if(numberLetters == 22){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: (match.dateOfMatch!))
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateOfMatch.text = dateFormatter.string(from: date!)
        } else if(numberLetters == 21){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: (match.dateOfMatch!))
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateOfMatch.text = dateFormatter.string(from: date!)
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: (match.dateOfMatch!))
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateOfMatch.text = dateFormatter.string(from: date!)
        }
        
        cell.lblResult.text = "Uitslag"
        cell.lblResultMatch.text = String(match.numberOfMatchesWonPlayer1!)  + ":" + String(match.numberOfMatchesWonPlayer2!)
        matchId = match.matchId!
        player1 = match.player
        opponent = match.opponent
        framesWonPlayer1 = match.numberOfMatchesWonPlayer1
        framesWonPlayer2 = match.numberOfMatchesWonPlayer2
        saveBreak = match.opslaanBreak
        cell.btnMatchstatistic.tag = match.matchId!
        cell.btnMatchstatistic.addTarget(self, action: #selector(nextScreen(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    var matchId: Int = 0
    var player1: String! = ""
    var opponent: String! = ""
    var framesWonPlayer1: Int! = 0
    var framesWonPlayer2: Int! = 0
    var saveBreak: Int! = 0
    
    //This is to go to the matchStatistic screen.
    @objc func nextScreen(sender: UIButton!){
        matchId = sender.tag
        self.performSegue(withIdentifier: "matchStatisticSegue", sender: self)
    }
    
    //This is to set the matchid in the matchStatisticController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let matchStatisticViewController = segue.destination as? MatchStatisticViewController else { return }
        matchStatisticViewController.matchId = matchId
    }
}

