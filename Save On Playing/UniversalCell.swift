//
//  UniversalCell.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 21/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import UIKit

class UniversalCell: UITableViewCell {

    @IBOutlet var linkLabel: UILabel!
    @IBOutlet var linkButton: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var discLabel: UILabel!
    @IBOutlet var oldPrLabel: UILabel!
    @IBOutlet var newPrLabel: UILabel!
    @IBOutlet var UniSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
