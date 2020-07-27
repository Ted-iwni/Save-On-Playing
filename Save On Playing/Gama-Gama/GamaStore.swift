//
//  HBStore.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 20/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import Foundation
import SwiftSoup

struct GamaDeal{
    let link: String
    let name: String
    let discount: String
    let oldPrice: String
    let newPrice: String
}

struct GamaStore {
    
    let gamaDeals: [GamaDeal]
    
    init(_ gamaHTML: Any?) throws {
        guard let htmlString = gamaHTML as? String else { throw HTMLError.badHTML}
        let doc = try SwiftSoup.parse(htmlString)
        let gamadoc = try doc.getElementById("catalog")!
        let links = try gamadoc.getElementsByClass("js_url").array()
        let names = try gamadoc.getElementsByClass("cropable").array()
        let discounts = try gamadoc.getElementsByClass("price_discount").array()
        let oldPrices = try gamadoc.getElementsByClass("old_price").array()
        let newPrices = try gamadoc.getElementsByClass("promo_price").array()
       

        
        var gamaDeals = [GamaDeal]()
        for i in 0..<names.count {
            let linkk = try links[i].attr("href")
            let link = ("https:\(linkk)")
            let name = try names[i].text()
            let discount = try discounts[i].text()
            let oldPrice = try oldPrices[i].text()
            var newPrice = try newPrices[i].text()

           let NEWPrices = newPrice.components(separatedBy: CharacterSet.decimalDigits.inverted)
            if NEWPrices.count < 7 {
               if let number = Int(NEWPrices[0]) {
                   newPrice = ("\(number) руб.")
                   if number > MaxPrice{
                       Price2High = true
                   }
               }
            } else {
                let number = Int(NEWPrices[0])! * 1000 + Int(NEWPrices[1])!
                newPrice = ("\(number) руб.")
                if number > MaxPrice{
                    Price2High = true
                }
            }

            if Price2High { Price2High = false }
                else {
           let gamaDeal = GamaDeal(link: link, name: name, discount: discount, oldPrice: oldPrice, newPrice: newPrice)
           gamaDeals.append(gamaDeal)
            }
        }
        self.gamaDeals = gamaDeals
    }

}
