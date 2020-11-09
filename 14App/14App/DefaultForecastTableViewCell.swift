//
//  DefaultForecastTableViewCell.swift
//  14App
//
//  Created by Norik on 20.10.2020.
//  Copyright © 2020 Norik. All rights reserved.
//

import UIKit

class DefaultForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempDayLabel: UILabel!
    @IBOutlet weak var tempNightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
