//
//  RegisterViewController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 11/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnRegister.backgroundColor = .clear
        btnRegister.layer.borderColor = UIColor.lightGray.cgColor
        btnRegister.layer.cornerRadius = 5
        btnRegister.layer.borderWidth = 1
        txtEmail.keyboardType = UIKeyboardType.emailAddress
    }
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
}
