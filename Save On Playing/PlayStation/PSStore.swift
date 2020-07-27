//
//  PSStore.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 20/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import Foundation
import SwiftSoup

struct PSDeal{
    let link: String
    let name: String
    let discount: String
    let oldPrice: String
    let newPrice: String
}

struct PSStore {
    
    let psDeals: [PSDeal]
    
    init(_ psHTML: Any?) throws {
        guard let htmlString = psHTML as? String else { throw HTMLError.badHTML}
        let doc = try SwiftSoup.parse(htmlString)
        let psdoc = try doc.getElementById("vsf-root")!
        let links = try psdoc.getElementsByClass("grid-cell__link internal-app-link ember-view").array()
        let names = try psdoc.getElementsByClass("grid-cell__title ").array()
        //let discounts = try psdoc.getElementsByClass("discount-badge__message").array()
        let oldPrices = try psdoc.getElementsByClass("price").array()
        let newPrices = try psdoc.getElementsByClass("price-display__price").array()

        
        var psDeals = [PSDeal]()
        for i in 0..<newPrices.count {
            let link = try links[i].attr("href")
            let name = try names[i].text()
            
            var oldPrice = try oldPrices[i].text()
            var newPrice = try newPrices[i].text()
            var discount: String
            
            for _ in 0...3 {
            oldPrice.remove(at: oldPrice.startIndex)
            newPrice.remove(at: newPrice.startIndex)
            }
            
            if (oldPrice.count) > 3 {
              let old = oldPrice.split(separator: ".")
              let oldP = Int(old[0])! * 1000 + Int(old[1])!
                
                if (newPrice.count) > 3 {
                    let new = newPrice.split(separator: ".")
                    let newP = Int(new[0])! * 1000 + Int(new[1])!
                    let newpp = Double(newP)
                    let oldd = Double(oldP)
                    let disco: Double = (newpp / oldd - 1) * 100
                    //print("disco??? = \(disco)")
                    let disc = "\(disco)".prefix(3)
                    discount = "\(disc)%"
                }
                else{
                    let newP = Int(newPrice)
                    let new = Double(newP!)
                    let oldd = Double(oldP)
                    let disco: Double = (new / oldd - 1) * 100
                    //print("disco??? = \(disco)")
                    let disc = "\(disco)".prefix(3)
                    discount = "\(disc)%"}
            }
            else {let oldP = Int(oldPrice)
              let newP = Int(newPrice)
              let new = Double(newP!)
              let oldd = Double(oldP!)
              let disco: Double = (new / oldd - 1) * 100
              //print("disco??? = \(disco)")
              let disc = "\(disco)".prefix(3)
                    discount = "\(disc)%"}

            oldPrice = "\(oldPrice) руб."
            newPrice = "\(newPrice) руб."
            
            var checkPrice = try newPrices[i].text()
            for _ in 0...3 {
            checkPrice.remove(at: checkPrice.startIndex)
            }
            
            if (checkPrice.count) > 3 {
                let new = checkPrice.split(separator: ".")
                let newP = Int(new[0])! * 1000 + Int(new[1])!
                            
                if newP > MaxPrice { Price2High = true }
            }
            else{
                let newP = Int(checkPrice)
                if newP! > MaxPrice { Price2High = true }
                }

           if Price2High {  Price2High = false }
           else {
           let psDeal = PSDeal(link: link, name: name, discount: discount, oldPrice: oldPrice, newPrice: newPrice)
           psDeals.append(psDeal)
           }
        }
        self.psDeals = psDeals
     }
   }
