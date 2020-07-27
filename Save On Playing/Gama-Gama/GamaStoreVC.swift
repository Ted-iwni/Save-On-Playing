//
//  GamaStoreVC.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 21/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import UIKit
import SafariServices

class GamaStoreVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var gamaDeals: [GamaDeal]!

    
    @IBAction func ToMain(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
       
    @IBOutlet var gamaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "UniversalCell", bundle: nil)
        gamaTableView.register(nib, forCellReuseIdentifier: "UniversalCell")
        gamaTableView.delegate = self
        gamaTableView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gamaTableView.deselectRow(at: indexPath, animated: true)
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamaDeals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gamaTableView.dequeueReusableCell(withIdentifier: "UniversalCell", for: indexPath) as! UniversalCell
        
        cell.linkButton.setImage(UIImage(named: "gama-gama Logo"), for: .normal)
        cell.linkButton.tag = indexPath.row
        cell.linkButton.addTarget(self, action: #selector(loadGamaGamaWebPage), for: .touchUpInside)
        
        cell.linkLabel.text = gamaDeals[indexPath.row].link
        cell.nameLabel.text = gamaDeals[indexPath.row].name
        cell.discLabel.text = gamaDeals[indexPath.row].discount
        cell.oldPrLabel.text = gamaDeals[indexPath.row].oldPrice
        cell.newPrLabel.text = gamaDeals[indexPath.row].newPrice
        
        cell.UniSwitch.tag = indexPath.row
        cell.UniSwitch.addTarget(self, action: #selector(gamaswitchSwitched), for: .valueChanged)
        
        return cell
    }
    
    
    @objc func loadGamaGamaWebPage(_ sender: UIButton){
        
        let index = sender.tag
        let vc = SFSafariViewController(url: URL(string: gamaDeals[index].link)!)
           present(vc, animated: true)
           }
    
    @IBAction func gamaswitchSwitched (_ sender: UISwitch){
        if sender.isOn {
        let index = sender.tag
        addFav(favLink: gamaDeals[index].link, favName: gamaDeals[index].name, favDisc: gamaDeals[index].discount, favOP: gamaDeals[index].oldPrice, favNP: gamaDeals[index].newPrice)
        } }
    
    @IBAction func ToWebStore(_ sender: UIButton) {
        
        let vc = SFSafariViewController(url: URL(string: "https://gama-gama.ru/?genre2=actions")!)
            present(vc, animated: true)
        
    }
    
}
