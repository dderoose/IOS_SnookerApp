//
//  MatchStatisticViewController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 15/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import Alamofire

class MatchStatisticViewController: UIViewController {
    var matchId: Int!
    var player1: String!
    var opponent: String!
    var framesWonPlayer1: Int!
    var framesWonPlayer2: Int!
    var saveBreak: Int!
    
    
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    @IBOutlet weak var lblFramesWonPlayer1: UILabel!
    @IBOutlet weak var lblFramesWonPlayer2: UILabel!
    @IBOutlet weak var lblNumberFramesPlayed: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let totalFramesPlayed = framesWonPlayer1+framesWonPlayer2
        lblPlayer1.numberOfLines = 0
        lblPlayer2.numberOfLines = 0
        lblNumberFramesPlayed.numberOfLines = 0
        
        lblPlayer1.text = player1!
        lblPlayer2.text = opponent!
        lblFramesWonPlayer1.text = String(framesWonPlayer1!)
        lblFramesWonPlayer2.text = String(framesWonPlayer2!)
        lblNumberFramesPlayed.text = "Frames: "+String(totalFramesPlayed)
        
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Frames/matchid/\(matchId!)").responseData { response in
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                let data: NSData = utf8Text.data(using: String.Encoding.utf8)! as NSData
                var _: NSError?
                
                do {
                    let jsonResult : AnyObject? = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as AnyObject
                    let frameListArray = (jsonResult as! NSArray) as Array
                    print(frameListArray)
                    //self.arrayBreaks = breakListArray
                    /*DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }*/
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    
}
