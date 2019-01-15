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


class ViewBreakController: UITableViewController {
    var listBreakss:Array<Breaks> = []
    var arrayBreaks: [AnyObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let jwt = try! decode(jwt: Constants.token)
        let name = jwt.claim(name: "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name")
        var username = ""
        if let nameUser = name.string {
            username = nameUser
        }
        
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Breaks/userid/\(username)").responseData { response in
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                let data: NSData = utf8Text.data(using: String.Encoding.utf8)! as NSData
                var _: NSError?
                
                do {
                    let jsonResult : AnyObject? = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as AnyObject
                    let breakListArray = (jsonResult as! NSArray) as Array
                    self.arrayBreaks = breakListArray
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
        return self.arrayBreaks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BreaksTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BreaksTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BreaksTableViewCell.")
        }        // Fetches the appropriate meal for the data source layout.
        let breaks = self.arrayBreaks[indexPath.row] as! NSDictionary
        
        cell.namebreak.text = (breaks["Player"] as! String)
        
        let numberLetters = (breaks["MomentPlayed"] as! String).count
        let dateFormatter = DateFormatter()
        if(numberLetters == 19){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: breaks["MomentPlayed"] as! String)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateBreak.text = dateFormatter.string(from: date)
        } else if(numberLetters == 23) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: breaks["MomentPlayed"] as! String)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateBreak.text = dateFormatter.string(from: date)
        } else if(numberLetters == 22){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: breaks["MomentPlayed"] as! String)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateBreak.text = dateFormatter.string(from: date)
        } else if(numberLetters == 21){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: breaks["MomentPlayed"] as! String)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateBreak.text = dateFormatter.string(from: date)
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            let date = dateFormatter.date(from: breaks["MomentPlayed"] as! String)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.dateBreak.text = dateFormatter.string(from: date)
        }
        cell.pointsBreak.text = String(breaks["NumberPoints"] as! Int)
        
        
        return cell
    }
}


