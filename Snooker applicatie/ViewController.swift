//
//  ViewController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 11/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnInlog.backgroundColor = .clear
        btnInlog.layer.borderColor = UIColor.lightGray.cgColor
        btnInlog.layer.cornerRadius = 5
        btnInlog.layer.borderWidth = 1
        btnRegister.backgroundColor = .clear
        btnRegister.layer.borderColor = UIColor.lightGray.cgColor
        btnRegister.layer.cornerRadius = 5
        btnRegister.layer.borderWidth = 1
        
        //api call
        /*Alamofire.request("http://backendapplications.azurewebsites.net/api/Breaks")
            .responseJSON{ (response) -> Void in
                
                if let JSON = response.result.value{
                    print(JSON)
                }
        }*/
        
        
    }
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnInlog: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBAction func btnInlogPressed(_ sender: UIButton) {
        let headers = [
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "grant_type": "password",
            "username": txtUsername?.text ?? "",
            "password": txtPassword?.text ?? ""
            ] as [String : Any]
        Alamofire.request("http://backendapplications.azurewebsites.net/token", method: .post,parameters: parameters, headers: headers).responseJSON { (response) -> Void in
            
            if let statuscode = response.response?.statusCode{
                if(statuscode == 400){
                    let toastLabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.size.height-100, width: (self.view.frame.width - 10), height: 70))
                    toastLabel.numberOfLines = 2
                    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                    toastLabel.textColor = UIColor.white
                    toastLabel.textAlignment = .center;
                    toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
                    toastLabel.text = "Er is een foute username of paswoord ingevuld"
                    toastLabel.alpha = 1.0
                    toastLabel.layer.cornerRadius = 10;
                    toastLabel.clipsToBounds  =  true
                    self.view.addSubview(toastLabel)
                    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                        toastLabel.alpha = 0.0
                    }, completion: {(isCompleted) in
                        toastLabel.removeFromSuperview()
                    })
                } else if(statuscode == 200){
                    let convertedString = String(describing: response.result.value!)
                    //let value = response.result.value! as NSString
                    let separatedQuotes = convertedString.components(separatedBy: "\"")
                    Constants.token = separatedQuotes[3]
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "navigationView")
                    self.present(newViewController, animated: true, completion: nil)
                } else {
                    
                }
            }
        }
    }
}

