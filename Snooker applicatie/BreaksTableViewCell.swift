//
//  BreaksTableViewCell.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 14/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import UIKit

class BreaksTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var namebreak: UILabel!
    @IBOutlet weak var dateBreak: UILabel!
    @IBOutlet weak var pointsBreak: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
