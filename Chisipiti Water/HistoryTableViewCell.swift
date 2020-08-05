//
//  HistoryTableViewCell.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 4/8/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addressTxt: UILabel!
    @IBOutlet weak var volumeTxt: UILabel!
    @IBOutlet weak var dateTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
