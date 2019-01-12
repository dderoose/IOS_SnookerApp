//
//  RegisterViewController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 11/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnRegister.backgroundColor = .clear
        btnRegister.layer.borderColor = UIColor.lightGray.cgColor
        btnRegister.layer.cornerRadius = 5
        btnRegister.layer.borderWidth = 1
        
        btnBack.backgroundColor = .clear
        btnBack.layer.borderColor = UIColor.lightGray.cgColor
        btnBack.layer.cornerRadius = 5
        btnBack.layer.borderWidth = 1
        
        txtEmail.keyboardType = UIKeyboardType.emailAddress
    }
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPasswordConfirm: UITextField!
    @IBAction func btnRegisterClicked(_ sender: UIButton) {
        let parameters = [
            "Username": txtUsername?.text ?? "",
            "Email": txtEmail?.text ?? "",
            "Password": txtPassword?.text ?? "",
            "ConfirmPassword": txtPasswordConfirm.text ?? ""
            ] as [String : Any]
        Alamofire.request("http://backendapplications.azurewebsites.net/api/account/Register", method: .post,parameters: parameters).responseJSON { (response) -> Void in
            if let statuscode = response.response?.statusCode{
                if(statuscode == 200){
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginView")
                    self.present(newViewController, animated: true, completion: nil)
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
}
