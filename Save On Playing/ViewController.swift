//
//  ViewController.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 11/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var UbiLogo: UIImageView!
    @IBOutlet weak var SteamLogo: UIImageView!
    @IBOutlet weak var PSLogo: UIImageView!
    @IBOutlet weak var GamaLogo: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
            
        case "ShowUbiDeals":do {
        guard let ubiDeals = sender as AnyObject as? [UbiDeal],
              let ubistoreVC = segue.destination as? UbiStoreVC
            else  { return }
        ubistoreVC.ubiDeals = ubiDeals
        }
            
        case "ShowSteamDeals":do {
        guard let steamDeals = sender as AnyObject as? [SteamDeal],
              let steamstoreVC = segue.destination as? SteamStoreVC
            else  { return }
        steamstoreVC.steamDeals = steamDeals
        }
            
        case "ShowPSDeals":do {
        guard let psDeals = sender as AnyObject as? [PSDeal],
              let psstoreVC = segue.destination as? PSStoreVC
            else  { return }
        psstoreVC.psDeals = psDeals
        }
        
        case "ShowGamaDeals":do {
        guard let gamaDeals = sender as AnyObject as? [GamaDeal],
              let gamastoreVC = segue.destination as? GamaStoreVC
            else  { return }
        gamastoreVC.gamaDeals = gamaDeals
            }
        default: break
        }
    }
  
    @IBAction func ToFavs(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let FavoritesVC = storyBoard.instantiateViewController(identifier: "Favs") as! FavoritesVC
        self.present(FavoritesVC, animated: true, completion: nil)
    }
    
    @IBAction func ToFilter(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let FilterViewController = storyBoard.instantiateViewController(identifier: "Filter") as! FilterViewController
        self.present(FilterViewController, animated: true, completion: nil)
    }
    
    @IBAction func ToUbiStore(_ sender: UIButton){
        let ubiURLString = ("https://store.ubi.com/ru/deals")
        guard let ubiURL = URL(string: ubiURLString) else {
            print("Error: \(ubiURLString) не является действующей ссылкой")
            return
        }
        do {
            let ubiHTML = try String(contentsOf: ubiURL)
            //print(ubiHTML)
            let ubiSent = try UbiStore(ubiHTML)
            //print("otpravleno v ubisoft deals")
            self.performSegue(withIdentifier: "ShowUbiDeals", sender: ubiSent.ubiDeals)
            
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    @IBAction func ToSteamStore(_ sender: UIButton){
        
        //let steamURLString = ("https://store.steampowered.com/search/?sort_by=&sort_order=0&category1=998&specials=1")
        let steamURLString = ("https://store.steampowered.com/search/?filter=topsellers&specials=1")
        guard let steamURL = URL(string: steamURLString) else {
            print("Error: \(steamURLString) не является действующей ссылкой")
            return
        }
        do {
            let steamHTML = try String(contentsOf: steamURL)
            let steamSent = try SteamStore(steamHTML)
            //print("otpravleno v steam deals")
            self.performSegue(withIdentifier: "ShowSteamDeals", sender: steamSent.steamDeals)
            
        } catch let error {
            print("Error: \(error)")
        }
    }
   
    
    @IBAction func ToPSStore(_ sender: UIButton){
        
        let psURLString = ("https://store.playstation.com/ru-ru/grid/STORE-MSF75508-GAMESUNDER202018/1")
        //let psURLString = ("https://store.playstation.com/ru-ru/grid/STORE-MSF75508-GAMESUNDER15/1?gameContentType=games")
        guard let psURL = URL(string: psURLString) else {
                print("Error: \(psURLString) не является действующей ссылкой")
                return
            }
            do {
                let psHTML = try String(contentsOf: psURL)
                //print(psHTML)
                let psSent = try PSStore(psHTML)
                //print("otpravleno v ps deals")
                self.performSegue(withIdentifier: "ShowPSDeals", sender: psSent.psDeals)

            } catch let error {
                print("Error: \(error)")
            }
        }
    
    
    @IBAction func ToGamaStore(_ sender: UIButton){
        
            let gamaURLString = ("https://gama-gama.ru/?genre2=actions")
            guard let gamaURL = URL(string: gamaURLString) else {
                    print("Error: \(gamaURLString) не является действующей ссылкой")
                    return
                }
                do {
                    let gamaHTML = try String(contentsOf: gamaURL)//print(hbHTML)
                    let gamaSent = try GamaStore(gamaHTML)
                    //print("otpravleno v gama gama deals")
                    self.performSegue(withIdentifier: "ShowGamaDeals", sender: gamaSent.gamaDeals)
                    
                } catch let error {
                    print("Error: \(error)")
                }
            }
}
