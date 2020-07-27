//
//  SteamStoreVC.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 19/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import UIKit
import SafariServices

class SteamStoreVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var steamDeals: [SteamDeal]!
    
    @IBAction func ToMain(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
       
    @IBOutlet var steamTableView: UITableView!
       
    override func viewDidLoad() {
        super.viewDidLoad()

         let nib = UINib(nibName: "SteamCell", bundle: nil)
              steamTableView.register(nib, forCellReuseIdentifier: "SteamCell")
              steamTableView.delegate = self
              steamTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           steamTableView.deselectRow(at: indexPath, animated: true)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steamDeals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = steamTableView.dequeueReusableCell(withIdentifier: "SteamCell", for: indexPath) as! SteamCell
        
        cell.linkButton.setImage(UIImage(named: "Steam logo"), for: .normal)
        cell.linkButton.tag = indexPath.row
        cell.linkButton.addTarget(self, action: #selector(loadSteamWebPage), for: .touchUpInside)
        
        cell.linkLabel.text = steamDeals[indexPath.row].link
        cell.nameLabel.text = steamDeals[indexPath.row].name
        cell.releaseLabel.text = steamDeals[indexPath.row].releasedate
        cell.discLabel.text = steamDeals[indexPath.row].discount
        cell.oldPrLabel.text = steamDeals[indexPath.row].oldPrice
        cell.newPrLabel.text = steamDeals[indexPath.row].newPrice
        
        cell.SteamSwitch.tag = indexPath.row
        cell.SteamSwitch.addTarget(self, action: #selector(steamswitchSwitched), for: .valueChanged)
        
        return cell
    }
    
  @objc func loadSteamWebPage(_ sender: UIButton){
      
      let index = sender.tag
      let vc = SFSafariViewController(url: URL(string: steamDeals[index].link)!)
         present(vc, animated: true)
         }
  
  @IBAction func steamswitchSwitched (_ sender: UISwitch){
      if sender.isOn {
      let index = sender.tag
      addFav(favLink: steamDeals[index].link, favName: steamDeals[index].name, favDisc: steamDeals[index].discount, favOP: steamDeals[index].oldPrice, favNP: steamDeals[index].newPrice)
      } }
    
    @IBAction func ToWebStore(_ sender: UIButton) {
        
        let vc = SFSafariViewController(url: URL(string: "https://store.steampowered.com/search/?filter=topsellers&specials=1")!)
            
            present(vc, animated: true)
        
        }
   
}
