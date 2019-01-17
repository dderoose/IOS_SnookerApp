//
//  FrameTableViewCell.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 17/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import UIKit

class FrameTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var lblBreaksPlayer1: UILabel!
    @IBOutlet weak var lblPointsPlayer1: UILabel!
    @IBOutlet weak var lblFrameNumber: UILabel!
    @IBOutlet weak var lblPointsPlayer2: UILabel!
    @IBOutlet weak var lblBreaksPlayer2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
