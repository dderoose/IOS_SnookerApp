//
//  AddBreakViewController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 15/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import JWTDecode

class AddBreakViewController: UIViewController{
    
    @IBOutlet weak var txtViewOpponent: UITextField!
    @IBOutlet weak var txtViewPoints: UITextField!
    @IBOutlet weak var txtViewDate: UITextField!
    @IBOutlet weak var txtViewTypeBreak: UITextField!
    @IBOutlet weak var btnAddBreak: UIButton!
    var fouten: String! = ""
    var datebreak : String! = ""
    @IBAction func btnAddBreakTapped(_ sender: UIButton) {
        fouten = ""
        if(txtViewPoints.text != "" && txtViewDate.text != "") {
            let jwt = try! decode(jwt: Constants.token)
            let name = jwt.claim(name: "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name")
            var username = ""
            if let nameUser = name.string {
                username = nameUser
            }
            datebreak = txtViewDate.text!+"T14:00:00"
            changeDateformat()
            /*let parameters = [
                "Player": "Dennis",
                "MomentPlayed": "2019-01-15T14:00:00",
                "NumberPoints": 180,
                "Opponent": "Francis",
                "TypeBreak": "Training"
                ] as [String : Any]*/
            
            print(username)
            print(txtViewPoints?.text! as Any)
            print(txtViewOpponent?.text! as Any)
            print(txtViewTypeBreak?.text as Any)
            datebreak = datebreak+"T14:00:00"
            let dateBreakString = String(datebreak)
            print(dateBreakString)
            let parameters = [
                "Player": username,
                "MomentPlayed": dateBreakString,
                "NumberPoints": txtViewPoints?.text ?? "",
                "Opponent": txtViewOpponent?.text ?? "",
                "TypeBreak": txtViewTypeBreak.text ?? ""
                ] as [String : Any]
            Alamofire.request("http://backendapplications.azurewebsites.net/api/Breaks", method: .post,parameters: parameters).responseJSON { (response) -> Void in
                if let statuscode = response.response?.statusCode{
                    if(statuscode == 201){
                        self.performSegue(withIdentifier: "addBreakSegue", sender: self)
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
        } else if(txtViewPoints.text == "" && txtViewDate.text == ""){
            fouten = "U hebt geen waarde ingevuld voor datum en aantal punten"
        } else if(txtViewPoints.text == ""){
            fouten = "U gaf geen geldige waarde in bij aantal punten"
        } else {
            fouten = "U heeft geen datum gekozen"
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
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAddBreak.backgroundColor = UIColor.lightGray
        btnAddBreak.layer.borderColor = UIColor.lightGray.cgColor
        btnAddBreak.layer.cornerRadius = 5
        btnAddBreak.layer.borderWidth = 1
        txtViewPoints.keyboardType = UIKeyboardType.numberPad
        showDatePicker()
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtViewDate.inputAccessoryView = toolbar
        txtViewDate.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtViewDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func changeDateformat(){
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: datePicker.date) // string purpose I add here
        // convert your string to date
        let myDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "yyyy-MM-dd"
        // again convert your date to string
        datebreak = formatter.string(from: myDate!)
        
        /*let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        datebreak = formatter.string(from: datebreak as! Date)
        self.view.endEditing(true)*/
    }
    
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
}
