//
//  ViewController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 11/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import UIKit

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
    }
    @IBOutlet weak var btnInlog: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
}

