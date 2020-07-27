//
//  UbiStoreVC.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 13/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import UIKit
import SafariServices


class UbiStoreVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ubiDeals: [UbiDeal]!
    
    @IBAction func ToMain(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var ubiTableView: UITableView!
//    let myData = ["сюда пихнуть результаты парсера"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "UbiCell", bundle: nil)
        ubiTableView.register(nib, forCellReuseIdentifier: "UbiCell")
        ubiTableView.delegate = self
        ubiTableView.dataSource = self
    }

    // TableView Functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           ubiTableView.deselectRow(at: indexPath, animated: true)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ubiDeals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ubiTableView.dequeueReusableCell(withIdentifier: "UbiCell", for: indexPath) as! UbiCell
        
        cell.linkButton.setImage(UIImage(named: "Ubisoft Logo"), for: .normal)
        cell.linkButton.tag = indexPath.row
        cell.linkButton.addTarget(self, action: #selector(loadUbiWebPage), for: .touchUpInside)
        
        cell.linkLabel.text = ubiDeals[indexPath.row].link
        cell.nameLabel.text = ubiDeals[indexPath.row].name
        cell.editionLabel.text = ubiDeals[indexPath.row].edition
        cell.discLabel.text = ubiDeals[indexPath.row].discount
        cell.oldPrLabel.text = ubiDeals[indexPath.row].oldPrice
        cell.newPrLabel.text = ubiDeals[indexPath.row].newPrice
       
        cell.UbiSwitch.tag = indexPath.row
        cell.UbiSwitch.addTarget(self, action: #selector(ubiswitchSwitched), for: .valueChanged)
        
        return cell
    }
    
    
        @objc func loadUbiWebPage(_ sender: UIButton){
            
            let index = sender.tag
            let vc = SFSafariViewController(url: URL(string: ubiDeals[index].link)!)
               present(vc, animated: true)
               }
        
        @IBAction func ubiswitchSwitched (_ sender: UISwitch){
            if sender.isOn {
            let index = sender.tag
            addFav(favLink: ubiDeals[index].link, favName: ubiDeals[index].name, favDisc: ubiDeals[index].discount, favOP: ubiDeals[index].oldPrice, favNP: ubiDeals[index].newPrice)
            } }
    
    @IBAction func ToWebStore(_ sender: UIButton) {
        
        let vc = SFSafariViewController(url: URL(string: "https://store.ubi.com/ru/deals")!)
            
        present(vc, animated: true)
        
        }
    }
    

