//
//  PSStoreVC.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 21/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

class PSStoreVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var psDeals: [PSDeal]!
    var CurrentIndex: Int!
    var urlPSLink = Array<String>();
    
    @IBAction func ToMain(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
       
    @IBOutlet weak var psTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "UniversalCell", bundle: nil)
        psTableView.register(nib, forCellReuseIdentifier: "UniversalCell")
        psTableView.delegate = self
        psTableView.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        psTableView.deselectRow(at: indexPath, animated: true)
    }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return psDeals.count
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = psTableView.dequeueReusableCell(withIdentifier: "UniversalCell", for: indexPath) as! UniversalCell

        cell.linkButton.setImage(UIImage(named: "PSStore Logo"), for: .normal)
        cell.linkButton.tag = indexPath.row
        cell.linkButton.addTarget(self, action: #selector(loadPSWebPage), for: .touchUpInside)
        
        cell.linkLabel.text = psDeals[indexPath.row].link
        
        urlPSLink.append("https://store.playstation.com/\(psDeals[indexPath.row].link)")
        
        cell.nameLabel.text = psDeals[indexPath.row].name
        cell.discLabel.text = psDeals[indexPath.row].discount
        cell.oldPrLabel.text = psDeals[indexPath.row].oldPrice
        cell.newPrLabel.text = psDeals[indexPath.row].newPrice
        
        cell.UniSwitch.tag = indexPath.row
        cell.UniSwitch.addTarget(self, action: #selector(psswitchSwitched), for: .valueChanged)
        
        
        //print("psDeals = \(psDeals.count)")
        print(" ")
      
        return cell
        
    }
    
    @objc func loadPSWebPage(_ sender: UIButton){
        
        let index = sender.tag
        let vc = SFSafariViewController(url: URL(string: urlPSLink[index])!)
           present(vc, animated: true)
           }
    
    @IBAction func psswitchSwitched (_ sender: UISwitch){
        if sender.isOn {
        let index = sender.tag
        addFav(favLink: urlPSLink[index], favName: psDeals[index].name, favDisc: psDeals[index].discount, favOP: psDeals[index].oldPrice, favNP: psDeals[index].newPrice)
        } }
       
        
    
    @IBAction func ToWebStore(_ sender: UIButton) {
        
        let vc = SFSafariViewController(url: URL(string: "https://store.playstation.com/ru-ru/grid/STORE-MSF75508-GAMESUNDER202018/1")!)

        present(vc, animated: true)
        
    }
    
    
}
