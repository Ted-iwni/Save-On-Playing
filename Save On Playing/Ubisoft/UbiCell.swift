//
//  UbiCell.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 13/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import UIKit

class UbiCell: UITableViewCell {

    @IBOutlet var linkLabel: UILabel!
    @IBOutlet var linkButton: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var editionLabel: UILabel!
    @IBOutlet var discLabel: UILabel!
    @IBOutlet var oldPrLabel: UILabel!
    @IBOutlet var newPrLabel: UILabel!
    @IBOutlet var UbiSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
