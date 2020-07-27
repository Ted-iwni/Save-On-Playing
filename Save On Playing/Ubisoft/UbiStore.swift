//
//  UbiStore.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 16/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import Foundation
import SwiftSoup

enum HTMLError: Error{
    case badHTML
}

struct UbiDeal{
    let link: String
    let name: String
    let edition: String
    let discount: String
    let oldPrice: String
    let newPrice: String
}

struct UbiStore {
    
    let ubiDeals: [UbiDeal]
    
    init(_ ubiHTML: Any?) throws {
        guard let htmlString = ubiHTML as? String else { throw HTMLError.badHTML }
        let doc = try SwiftSoup.parse(htmlString)
        let ubidoc = try doc.getElementById("search-result-items")!
        let links = try ubidoc.getElementsByClass("thumb-link").array()
        let names = try ubidoc.getElementsByClass("prod-title").array()
        let editions = try ubidoc.getElementsByClass("card-subtitle").array()
        let discounts = try ubidoc.getElementsByClass("deal-percentage card-label card-deal").array()
        let oldPrices = try ubidoc.getElementsByClass("price-item").array()
        let newPrices = try ubidoc.getElementsByClass("price-sales standard-price").array()
        
        var ubiDeals = [UbiDeal]()
        for i in 0..<names.count {
            let linkk = try links[i].attr("href")
            let link = ("https://store.ubi.com/\(linkk)")
            let name = try names[i].text()
            let edition = try editions[i].text()
            let discount = try discounts[i].text()
            let oldPrice = try oldPrices[i].text()
            var newPrice = try newPrices[i].text()

            let NEWPrices = newPrice.components(separatedBy: CharacterSet.decimalDigits.inverted)
            //print(NEWPrices)
             if NEWPrices.count < 7 {
                if let number = Int(NEWPrices[0]) {
                    newPrice = ("\(number) руб.")
                     //print(number)
                    if number > MaxPrice{
                        Price2High = true
                    }
                }
             } else {
                 let number = Int(NEWPrices[0])! * 1000 + Int(NEWPrices[1])!
                 newPrice = ("\(number) руб.")
                 //print(number)
                 if number > MaxPrice{
                     Price2High = true
                 }
             }
            
            if Price2High { Price2High = false }
            else {
            let ubiDeal = UbiDeal(link: link, name: name, edition: edition, discount: discount, oldPrice: oldPrice, newPrice: newPrice)
            ubiDeals.append(ubiDeal)
            }
          }
        self.ubiDeals = ubiDeals
    }
}

