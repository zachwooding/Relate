//
//  ObjsTableViewCell.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 5/2/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import UIKit

class ObjsTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureLabel: UILabel!
    @IBOutlet weak var objsNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
