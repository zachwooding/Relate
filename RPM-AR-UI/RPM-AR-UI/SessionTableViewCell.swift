//
//  SessionTableViewCell.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 4/23/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet weak var childNameLabel: UILabel!
    @IBOutlet weak var sessionNumber: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
