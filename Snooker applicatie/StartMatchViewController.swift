//
//  StartMatchViewController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 16/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import JWTDecode

class StartMatchViewController: UIViewController{

    @IBOutlet weak var txtOpponent: UITextField!
    @IBOutlet weak var txtFramesToPlay: UITextField!
    @IBOutlet weak var txtSaveBreakFrom: UITextField!
    @IBOutlet weak var btnStartMatch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStartMatch.backgroundColor = UIColor.lightGray
        btnStartMatch.layer.borderColor = UIColor.lightGray.cgColor
        btnStartMatch.layer.cornerRadius = 5
        btnStartMatch.layer.borderWidth = 1
        txtSaveBreakFrom.keyboardType = UIKeyboardType.numberPad
        txtFramesToPlay.keyboardType = UIKeyboardType.numberPad
        btnStartMatch.addTarget(self, action: #selector(matchScreen(sender:)), for: .touchUpInside)
    }
    
    var fouten: String! = ""
    var matchid: Int = 0
    
    @objc func matchScreen(sender: UIButton!){
        fouten = ""
        if(txtOpponent.text != "" && txtFramesToPlay.text != "" && txtSaveBreakFrom.text != "") {
            let jwt = try! decode(jwt: Constants.token)
            
            let name = jwt.claim(name: "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name")
            var username = ""
            if let nameUser = name.string {
                username = nameUser
            }
            
            let identifier = jwt.claim(name: "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier")
            var id = ""
            if let idUser = identifier.string {
                id = idUser
            }
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let result = formatter.string(from: date)
            let parameters = [
                "MatchId": 1,
                "PotSucces": 0.0,
                "Player": username,
                "Opponent": txtOpponent?.text ?? "",
                "SafetySucces": 0.0,
                "DurationMatch": "2018-12-28T14:00:00",
                "DateOfMatch": result,
                "NumberMatchesWonPlayer1": 0,
                "NumberMatchesWonPlayer2": 0,
                "OpslaanBreak": Int((txtSaveBreakFrom?.text)!) ?? 0,
                "UserId": id
                ] as [String : Any]
            Alamofire.request("http://backendapplications.azurewebsites.net/api/Matches", method: .post,parameters: parameters).responseJSON { (response) -> Void in
                if let statuscode = response.response?.statusCode{
                    if(statuscode == 201){
                        let convertedString = String(describing: response.result.value!)
                        let separatedSpace = convertedString.components(separatedBy: " ")
                        let separatedPoinKomma = separatedSpace[24].components(separatedBy: ";")
                        self.matchid = Int(separatedPoinKomma[0])!
                        self.performSegue(withIdentifier: "startMatchSegue", sender: self)
                        
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
        }else {
            fouten = "U heeft niet alle velden ingevuld"
        }
        
        if(fouten != ""){
            let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
            toastLabel.numberOfLines = 2
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
            toastLabel.text = fouten
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let matchViewController = segue.destination as? MatchViewController else { return }
        matchViewController.id = matchid
    }

}
