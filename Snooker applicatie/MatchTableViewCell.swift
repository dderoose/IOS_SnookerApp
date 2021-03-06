//
//  MatchTableViewCell.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 15/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import UIKit

//Here are the labels and the button of the matchttableviewcell
class MatchTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var playersOfMatch: UILabel!
    @IBOutlet weak var dateOfMatch: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblResultMatch: UILabel!
    @IBOutlet weak var btnMatchstatistic: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
