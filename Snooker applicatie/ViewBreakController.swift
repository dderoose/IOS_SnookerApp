//
//  ViewBreakController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 14/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import JWTDecode
import AlamofireObjectMapper

//This is a controller for the breaktableview.
class ViewBreakController: UITableViewController {
    var listBreakss:Array<Breaks> = []
    var arrayBreaks: [AnyObject] = []
    
    /*We decode the jwttoken to get the username of the user
     and we also do a call to get all the breaks
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        let jwt = try! decode(jwt: Constants.token)
        let name = jwt.claim(name: "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name")
        var username = ""
        if let nameUser = name.string {
            username = nameUser
        }
        
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Breaks/userid/\(username)").responseArray { (response: DataResponse<[Breaks]>) in
            
            self.arrayBreaks = response.result.value!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //This is to set the numberOfSections in the tableview
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //This is to know how much rows they need to set in the tableview.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayBreaks.count
    }
    
    //Here we fill in the cells from a tableviewcell with values from the breakarray
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BreaksTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BreaksTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BreaksTableViewCell.")
        }
        let breaks = self.arrayBreaks[indexPath.row] as! Breaks
        cell.namebreak.text = (breaks.player)
        
        let numberLetters = (breaks.momentPlayed)!.count
        let dateFormatter = DateFormatter()
        if(numberLetters == 19){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: (breaks.momentPlayed!))
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateBreak.text = dateFormatter.string(from: date!)
        } else if(numberLetters == 23) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: (breaks.momentPlayed!))!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateBreak.text = dateFormatter.string(from: date)
        } else if(numberLetters == 22){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: (breaks.momentPlayed!))!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateBreak.text = dateFormatter.string(from: date)
        } else if(numberLetters == 21){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: (breaks.momentPlayed!))!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateBreak.text = dateFormatter.string(from: date)
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: (breaks.momentPlayed!))!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateBreak.text = dateFormatter.string(from: date)
        }
        cell.pointsBreak.text = String(breaks.numberPoints!)
        
        
        return cell
    }
}


