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

    
    @IBOutlet weak var OverviewView: UIView!
    @IBOutlet weak var TrailingC: NSLayoutConstraint!
    @IBOutlet weak var LeadingC: NSLayoutConstraint!
    
    var hamburgerMenuIsVisible = false
    
    @IBAction func hamburgerBtnTapped(_ sender: Any) {
        if !hamburgerMenuIsVisible{
            LeadingC.constant = 150
            TrailingC.constant = -150
            hamburgerMenuIsVisible = true
        } else {
            LeadingC.constant = 0
            TrailingC.constant = 0
            hamburgerMenuIsVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
    }
}
