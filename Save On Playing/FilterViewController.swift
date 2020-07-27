//
//  FilterViewController.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 01/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import UIKit

var MaxPrice: Int = 10000
var Price2High: Bool = false

class FilterViewController: UIViewController {

    @IBAction func ToMain(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
     }
 
    @IBOutlet weak var MaxPriceLabel: UILabel!
    
    @IBOutlet weak var PriceLabel: UILabel!
    
    @IBOutlet weak var PriceSlider: UISlider!
    
    @IBAction func PriceSlider(_ sender: UISlider) {
        PriceLabel.text = String(Int(PriceSlider.value))
        MaxPrice = Int(PriceSlider.value)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
}
