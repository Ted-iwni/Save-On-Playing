//
//  FavoritesViewController.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 11/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//
import UIKit
import SafariServices

class FavoritesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
        @IBAction func ToMain(_ sender: UIButton) {
            self.dismiss(animated: true, completion: nil)
        }
        
        @IBOutlet var tableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let nib = UINib(nibName: "FavsCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "FavsCell")
            tableView.dataSource = self
            tableView.delegate = self
            loadData()
        }
               
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Favs.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavsCell", for: indexPath) as! FavsCell
            
            cell.linkButton.setImage(UIImage(named: "LaunchIcon"), for: .normal)
            cell.linkButton.tag = indexPath.row
            cell.linkButton.addTarget(self, action: #selector(loadWebPage), for: .touchUpInside)
            
            cell.linkLabel.text = Favs[indexPath.row].Link
            cell.nameLabel.text = Favs[indexPath.row].Name
            cell.discLabel.text = Favs[indexPath.row].Disc
            cell.oldPrLabel.text = Favs[indexPath.row].OldP
            cell.newPrLabel.text = Favs[indexPath.row].NewP
           
            return cell
            }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            removeFav(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
   
    @objc func loadWebPage(_ sender: UIButton){
            
    let index = sender.tag
    let vc = SFSafariViewController(url: URL(string: Favs[index].Link)!)
    present(vc, animated: true)
        }

}
