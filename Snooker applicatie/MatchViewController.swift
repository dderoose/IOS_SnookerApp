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
    
    var frameId: Int!
    var framesWonPlayer1: Int! = 0
    var framesWonPlayer2: Int! = 0

    @IBOutlet weak var btnAddScorePlayer1: UIButton!
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    @IBOutlet weak var lblFramesPlayed: UILabel!
    @IBOutlet weak var lblScorePlayer1: UILabel!
    @IBOutlet weak var lblScorePlayer2: UILabel!
    @IBOutlet weak var txtAddScorePlayer1: UITextField!
    @IBOutlet weak var txtAddScorePlayer2: UITextField!
    @IBOutlet weak var btnAddScorePlayer2: UIButton!
    @IBOutlet weak var btnEndFrame: UIButton!
    @IBOutlet weak var btnEndMatch: UIButton!
    @IBAction func btnEndMatchTapped(_ sender: Any) {
        if(Int(lblScorePlayer1.text!)! >= Int(lblScorePlayer2.text!)!){
            framesWonPlayer1 = framesWonPlayer1+1
            let parameters = [
                "FrameId": frameId,
                "DurationFrame": 0.0,
                "PointsWinner": Int(lblScorePlayer1.text!)!,
                "PointsOpponent": Int(lblScorePlayer2.text!)!,
                "Winner": player!,
                "MatchId": matchId
                ] as [String : Any]
            Alamofire.request("http://backendapplications.azurewebsites.net/api/Frames/\(frameId!)", method: .put,parameters: parameters).responseJSON { (response) -> Void in
                if let statuscode = response.response?.statusCode{
                    if(statuscode == 204){
                        
                    } else{
                        let errorss = response.description
                        let errorsplit = errorss.components(separatedBy: "\"")
                        var errorMerge = ""
                        for i in stride(from: 9, to: errorsplit.count, by: 4) {
                            errorMerge = errorMerge + errorsplit[i]
                        }
                        
                        
                        let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
                        toastLabel.numberOfLines = 2
                        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                        toastLabel.textColor = UIColor.white
                        toastLabel.textAlignment = .center;
                        toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
                        toastLabel.text = errorMerge
                        toastLabel.alpha = 1.0
                        toastLabel.layer.cornerRadius = 10;
                        toastLabel.clipsToBounds  =  true
                        self.view.addSubview(toastLabel)
                        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                            toastLabel.alpha = 0.0
                        }, completion: {(isCompleted) in
                            toastLabel.removeFromSuperview()
                        })
                    }
                }
            }
            
        } else {
            framesWonPlayer2 = framesWonPlayer2+1
            let parameters = [
                "FrameId": frameId,
                "DurationFrame": 0.0,
                "PointsWinner": Int(lblScorePlayer1.text!)!,
                "PointsOpponent": Int(lblScorePlayer2.text!)!,
                "Winner": opponent!,
                "MatchId": matchId
                ] as [String : Any]
            Alamofire.request("http://backendapplications.azurewebsites.net/api/Frames/\(frameId!)", method: .put,parameters: parameters).responseJSON { (response) -> Void in
                if let statuscode = response.response?.statusCode{
                    if(statuscode == 204){
                        
                    } else{
                        let errorss = response.description
                        let errorsplit = errorss.components(separatedBy: "\"")
                        var errorMerge = ""
                        for i in stride(from: 9, to: errorsplit.count, by: 4) {
                            errorMerge = errorMerge + errorsplit[i]
                        }
                        
                        
                        let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
                        toastLabel.numberOfLines = 2
                        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                        toastLabel.textColor = UIColor.white
                        toastLabel.textAlignment = .center;
                        toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
                        toastLabel.text = errorMerge
                        toastLabel.alpha = 1.0
                        toastLabel.layer.cornerRadius = 10;
                        toastLabel.clipsToBounds  =  true
                        self.view.addSubview(toastLabel)
                        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                            toastLabel.alpha = 0.0
                        }, completion: {(isCompleted) in
                            toastLabel.removeFromSuperview()
                        })
                    }
                }
            }
        }
        let jwt = try! decode(jwt: Constants.token)
        let name = jwt.claim(name: "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier")
        var id = ""
        if let idUser = name.string {
            id = idUser
        }
        print(dateOfMatch!)
        let parameters = [
            "MatchId": matchId,
            "PotSucces": 0.0,
            "Player": player!,
            "Opponent": opponent!,
            "SafetySucces": 0.0,
            "DurationMatch": "2018-12-28T14:00:00",
            "DateOfMatch": dateOfMatch!,
            "NumberMatchesWonPlayer1": framesWonPlayer1,
            "NumberMatchesWonPlayer2": framesWonPlayer2,
            "OpslaanBreak": saveBreak,
            "UserId": id
            ] as [String : Any]
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Matches/\(matchId!)", method: .put,parameters: parameters).responseJSON { (response) -> Void in
            if let statuscode = response.response?.statusCode{
                if(statuscode == 204){
                    self.performSegue(withIdentifier: "endMatchSegue", sender: self)
                } else{
                    let errorss = response.description
                    let errorsplit = errorss.components(separatedBy: "\"")
                    var errorMerge = ""
                    for i in stride(from: 9, to: errorsplit.count, by: 4) {
                        errorMerge = errorMerge + errorsplit[i]
                    }
                    
                    
                    let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
                    toastLabel.numberOfLines = 2
                    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                    toastLabel.textColor = UIColor.white
                    toastLabel.textAlignment = .center;
                    toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
                    toastLabel.text = errorMerge
                    toastLabel.alpha = 1.0
                    toastLabel.layer.cornerRadius = 10;
                    toastLabel.clipsToBounds  =  true
                    self.view.addSubview(toastLabel)
                    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                        toastLabel.alpha = 0.0
                    }, completion: {(isCompleted) in
                        toastLabel.removeFromSuperview()
                    })
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.backgroundColor = UIColor.blue
        navigationBarAppearace.barTintColor = UIColor.blue
        navigationBarAppearace.tintColor = UIColor.white
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
        lblPlayer1.text = player!
        lblPlayer2.text = opponent!
        lblFramesPlayed.numberOfLines = 0
        lblFramesPlayed.text = "Aantal gespeelde frames:"+String(playedFrames)+"/"+String(bestOf)
        self.navigationItem.setHidesBackButton(true, animated:true);
        let parameters = [
            "FrameId": 80,
            "DurationFrame": 0.0,
            "PointsWinner": 0,
            "PointsOpponent": 0,
            "Winner": "",
            "MatchId": matchId
            ] as [String : Any]
        
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Frames", method: .post,parameters: parameters).responseJSON { (response) -> Void in
            if let statuscode = response.response?.statusCode{
                if(statuscode == 201){
                    let convertedString = String(describing: response.result.value!)
                    let separatedSpace = convertedString.components(separatedBy: " ")
                    let separatedPointKomma = separatedSpace[18].components(separatedBy: ";")
                    self.frameId = Int(separatedPointKomma[0])!
                } else{
                    let errorss = response.description
                    let errorsplit = errorss.components(separatedBy: "\"")
                    var errorMerge = ""
                    for i in stride(from: 9, to: errorsplit.count, by: 4) {
                        errorMerge = errorMerge + errorsplit[i]
                    }
                    
                    
                    let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
                    toastLabel.numberOfLines = 2
                    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                    toastLabel.textColor = UIColor.white
                    toastLabel.textAlignment = .center;
                    toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
                    toastLabel.text = errorMerge
                    toastLabel.alpha = 1.0
                    toastLabel.layer.cornerRadius = 10;
                    toastLabel.clipsToBounds  =  true
                    self.view.addSubview(toastLabel)
                    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                        toastLabel.alpha = 0.0
                    }, completion: {(isCompleted) in
                        toastLabel.removeFromSuperview()
                    })
                }
                
            }
        }
        
        
        
    }
    
    @IBAction func btnAddScorePlayer1Tapped(_ sender: Any) {
        if(txtAddScorePlayer1.text != ""){
            if(Int(txtAddScorePlayer1.text!)! >= saveBreak) {
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let result = formatter.string(from: date)
                let parameters = [
                    "BreakId": 80,
                    "Player": player!,
                    "MomentPlayed": result,
                    "NumberPoints": Int(txtAddScorePlayer1.text!)!,
                    "Opponent": opponent!,
                    "TypeBreak": "Match",
                    "FrameId": frameId
                    ] as [String : Any]
                Alamofire.request("http://backendapplications.azurewebsites.net/api/Breaks", method: .post,parameters: parameters).responseJSON { (response) -> Void in
                    if let statuscode = response.response?.statusCode{
                        if(statuscode == 201){
                        } else{
                            let errorss = response.description
                            let errorsplit = errorss.components(separatedBy: "\"")
                            var errorMerge = ""
                            for i in stride(from: 9, to: errorsplit.count, by: 4) {
                                errorMerge = errorMerge + errorsplit[i]
                            }
                            
                            
                            let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
                            toastLabel.numberOfLines = 2
                            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                            toastLabel.textColor = UIColor.white
                            toastLabel.textAlignment = .center;
                            toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
                            toastLabel.text = errorMerge
                            toastLabel.alpha = 1.0
                            toastLabel.layer.cornerRadius = 10;
                            toastLabel.clipsToBounds  =  true
                            self.view.addSubview(toastLabel)
                            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                                toastLabel.alpha = 0.0
                            }, completion: {(isCompleted) in
                                toastLabel.removeFromSuperview()
                            })
                        }
                        
                    }
                }
            }
            lblScorePlayer1.text = String(Int(lblScorePlayer1.text!)!+Int(txtAddScorePlayer1.text!)!)
            txtAddScorePlayer1.text = ""
        } else {
            let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
            toastLabel.numberOfLines = 2
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
            toastLabel.text = "U vulde geen waarde in"
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }
    
    @IBAction func btnAddScorePlayer2Tapped(_ sender: Any) {
        if(txtAddScorePlayer2.text != ""){
            if(Int(txtAddScorePlayer2.text!)! >= saveBreak) {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let result = formatter.string(from: date)
            let parameters = [
                "BreakId": 80,
                "Player": opponent!,
                "MomentPlayed": result,
                "NumberPoints": Int(txtAddScorePlayer2.text!)!,
                "Opponent": player!,
                "TypeBreak": "Match",
                "FrameId": frameId
                ] as [String : Any]
            Alamofire.request("http://backendapplications.azurewebsites.net/api/Breaks", method: .post,parameters: parameters).responseJSON { (response) -> Void in
                if let statuscode = response.response?.statusCode{
                    if(statuscode == 201){
                        
                    } else{
                        let errorss = response.description
                        let errorsplit = errorss.components(separatedBy: "\"")
                        var errorMerge = ""
                        for i in stride(from: 9, to: errorsplit.count, by: 4) {
                            errorMerge = errorMerge + errorsplit[i]
                        }
                        
                        
                        let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
                        toastLabel.numberOfLines = 2
                        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                        toastLabel.textColor = UIColor.white
                        toastLabel.textAlignment = .center;
                        toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
                        toastLabel.text = errorMerge
                        toastLabel.alpha = 1.0
                        toastLabel.layer.cornerRadius = 10;
                        toastLabel.clipsToBounds  =  true
                        self.view.addSubview(toastLabel)
                        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                            toastLabel.alpha = 0.0
                        }, completion: {(isCompleted) in
                            toastLabel.removeFromSuperview()
                        })
                    }
                }
                }
            }
            lblScorePlayer2.text = String(Int(lblScorePlayer2.text!)!+Int(txtAddScorePlayer2.text!)!)
            txtAddScorePlayer2.text = ""
        } else {
            let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
            toastLabel.numberOfLines = 2
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
            toastLabel.text = "U vulde geen waarde in"
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    
    }
    @IBAction func btnEndFrameTapped(_ sender: Any) {
        if(playedFrames+1 >= bestOf){
            btnEndFrame.isHidden = true
        }
        if(Int(lblScorePlayer1.text!)! >= Int(lblScorePlayer2.text!)!){
            framesWonPlayer1 = framesWonPlayer1+1
            let parameters = [
                "FrameId": frameId,
                "DurationFrame": 0.0,
                "PointsWinner": Int(lblScorePlayer1.text!)!,
                "PointsOpponent": Int(lblScorePlayer2.text!)!,
                "Winner": player!,
                "MatchId": matchId
                ] as [String : Any]
            Alamofire.request("http://backendapplications.azurewebsites.net/api/Frames/\(frameId!)", method: .put,parameters: parameters).responseJSON { (response) -> Void in
                if let statuscode = response.response?.statusCode{
                    if(statuscode == 204){
                        
                    } else{
                        let errorss = response.description
                        let errorsplit = errorss.components(separatedBy: "\"")
                        var errorMerge = ""
                        for i in stride(from: 9, to: errorsplit.count, by: 4) {
                            errorMerge = errorMerge + errorsplit[i]
                        }
                        
                        
                        let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
                        toastLabel.numberOfLines = 2
                        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                        toastLabel.textColor = UIColor.white
                        toastLabel.textAlignment = .center;
                        toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
                        toastLabel.text = errorMerge
                        toastLabel.alpha = 1.0
                        toastLabel.layer.cornerRadius = 10;
                        toastLabel.clipsToBounds  =  true
                        self.view.addSubview(toastLabel)
                        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                            toastLabel.alpha = 0.0
                        }, completion: {(isCompleted) in
                            toastLabel.removeFromSuperview()
                        })
                    }
                }
            }
            
        } else {
            framesWonPlayer2 = framesWonPlayer2+1
            let parameters = [
                "FrameId": frameId,
                "DurationFrame": 0.0,
                "PointsWinner": Int(lblScorePlayer1.text!)!,
                "PointsOpponent": Int(lblScorePlayer2.text!)!,
                "Winner": opponent!,
                "MatchId": matchId
                ] as [String : Any]
            Alamofire.request("http://backendapplications.azurewebsites.net/api/Frames/\(frameId!)", method: .put,parameters: parameters).responseJSON { (response) -> Void in
                if let statuscode = response.response?.statusCode{
                    if(statuscode == 204){
                        
                    } else{
                        let errorss = response.description
                        let errorsplit = errorss.components(separatedBy: "\"")
                        var errorMerge = ""
                        for i in stride(from: 9, to: errorsplit.count, by: 4) {
                            errorMerge = errorMerge + errorsplit[i]
                        }
                        
                        
                        let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
                        toastLabel.numberOfLines = 2
                        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                        toastLabel.textColor = UIColor.white
                        toastLabel.textAlignment = .center;
                        toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
                        toastLabel.text = errorMerge
                        toastLabel.alpha = 1.0
                        toastLabel.layer.cornerRadius = 10;
                        toastLabel.clipsToBounds  =  true
                        self.view.addSubview(toastLabel)
                        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                            toastLabel.alpha = 0.0
                        }, completion: {(isCompleted) in
                            toastLabel.removeFromSuperview()
                        })
                    }
                }
            }
        }
        let parameters = [
            "FrameId": 80,
            "DurationFrame": 0.0,
            "PointsWinner": 0,
            "PointsOpponent": 0,
            "Winner": "",
            "MatchId": matchId
            ] as [String : Any]
        
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Frames", method: .post,parameters: parameters).responseJSON { (response) -> Void in
            if let statuscode = response.response?.statusCode{
                if(statuscode == 201){
                    let convertedString = String(describing: response.result.value!)
                    let separatedSpace = convertedString.components(separatedBy: " ")
                    let separatedPointKomma = separatedSpace[18].components(separatedBy: ";")
                    self.frameId = Int(separatedPointKomma[0])!
                } else{
                    let errorss = response.description
                    let errorsplit = errorss.components(separatedBy: "\"")
                    var errorMerge = ""
                    for i in stride(from: 9, to: errorsplit.count, by: 4) {
                        errorMerge = errorMerge + errorsplit[i]
                    }
                    
                    
                    let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
                    toastLabel.numberOfLines = 2
                    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                    toastLabel.textColor = UIColor.white
                    toastLabel.textAlignment = .center;
                    toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
                    toastLabel.text = errorMerge
                    toastLabel.alpha = 1.0
                    toastLabel.layer.cornerRadius = 10;
                    toastLabel.clipsToBounds  =  true
                    self.view.addSubview(toastLabel)
                    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                        toastLabel.alpha = 0.0
                    }, completion: {(isCompleted) in
                        toastLabel.removeFromSuperview()
                    })
                }
                
            }
        }
        playedFrames = playedFrames+1
        lblFramesPlayed.text = "Aantal gespeelde frames:"+String(playedFrames)+"/"+String(bestOf)
        lblScorePlayer1.text = "0"
        lblScorePlayer2.text = "0"
        txtAddScorePlayer1.text = ""
        txtAddScorePlayer2.text = ""
        
    }
}
