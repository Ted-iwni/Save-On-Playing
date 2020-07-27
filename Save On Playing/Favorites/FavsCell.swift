//
//  FavsCell.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 25/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import UIKit

class FavsCell: UITableViewCell {

      @IBOutlet var linkLabel: UILabel!
      @IBOutlet var linkButton: UIButton!
      @IBOutlet var nameLabel: UILabel!
      @IBOutlet var discLabel: UILabel!
      @IBOutlet var oldPrLabel: UILabel!
      @IBOutlet var newPrLabel: UILabel!
      
      
      override func awakeFromNib() {
          super.awakeFromNib()
      }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          }
}
