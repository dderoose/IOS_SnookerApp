//
//  OverviewViewController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 11/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import UIKit

class OverviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        OverviewView.layer.zPosition = 0
        navBarView.layer.zPosition = 1
        navBarView.backgroundColor = UIColor.gray
        NavBarPictureView.layer.zPosition = 2
        navBarUnderPicture.layer.zPosition = 2
        btnStartMatch.titleEdgeInsets = UIEdgeInsets(top:20,left:20,bottom:20,right:0)
        btnShowBreak.titleEdgeInsets = UIEdgeInsets(top:20,left:20,bottom:20,right:0)
        btnAddBreak.titleEdgeInsets = UIEdgeInsets(top:20,left:20,bottom:20,right:0)
        btnMatchStatistic.titleEdgeInsets = UIEdgeInsets(top:20,left:20,bottom:20,right:0)

        NavBarPictureView.isHidden = true
        navBarView.isHidden = true
        navBar.isHidden = true
    }
    @IBOutlet weak var navBarUnderPicture: UIView!
    @IBOutlet weak var NavBarPictureView: UIView!
    @IBOutlet weak var btnMatchStatistic: UIButton!
    @IBOutlet weak var btnShowBreak: UIButton!
    @IBOutlet weak var btnAddBreak: UIButton!
    @IBOutlet weak var btnStartMatch: UIButton!
    @IBOutlet var OverviewView: UIView!
    @IBOutlet weak var TrailingC: NSLayoutConstraint!
    @IBOutlet weak var LeadingC: NSLayoutConstraint!
    @IBOutlet weak var navBar: UIStackView!
    @IBOutlet weak var navBarView: UIView!
    
    var hamburgerMenuIsVisible = false
    
    @IBAction func hamburgerBtnTapped(_ sender: Any) {
        if !hamburgerMenuIsVisible{
            NavBarPictureView.isHidden = false
            navBarView.isHidden = false
            navBar.isHidden = false
            hamburgerMenuIsVisible = true
        } else {
            NavBarPictureView.isHidden = true
            navBarView.isHidden = true
            navBar.isHidden = true
            hamburgerMenuIsVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
    }
}
