//
//  SteamStore.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 19/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import Foundation
import SwiftSoup

struct SteamDeal{
    let link: String
    let name: String
    let releasedate: String
    let discount: String
    var oldPrice: String
    var newPrice: String
}

struct SteamStore {
    
    let steamDeals: [SteamDeal]
    
    init(_ steamHTML: Any?) throws {
        guard let htmlString = steamHTML as? String else { throw HTMLError.badHTML}
        let doc = try SwiftSoup.parse(htmlString)
        let steamdoc = try doc.getElementById("search_resultsRows")!
        let links = try steamdoc.getElementsByTag("a").array()
        let names = try steamdoc.getElementsByClass("title").array()
        let releasedates = try steamdoc.getElementsByClass("col search_released responsive_secondrow").array()
        let discounts = try steamdoc.getElementsByClass("col search_discount responsive_secondrow").array()
        let oldPrices = try steamdoc.getElementsByClass("col search_price discounted responsive_secondrow").array()
        //let newPrices = try steamdoc.getElementsByClass("col search_price discounted responsive_secondrow").select("br").array()
       

        
    var steamDeals = [SteamDeal]()
    for i in 0..<names.count {
        let link = try links[i].attr("href")
        let name = try names[i].text()
        let releasedate = try releasedates[i].text()
        let discount = try discounts[i].text()
        var oldPrice = try oldPrices[i].text()
        var newPrice: String = ""

        let NEWPrices = oldPrice.components(separatedBy: CharacterSet.decimalDigits.inverted)
        oldPrice = ("\(NEWPrices[0]) руб.")
        newPrice = ("\(NEWPrices[6]) руб.")
        let checkPrice = Int(NEWPrices[6])
            
        if checkPrice! > MaxPrice { Price2High = true }
            
        if Price2High { Price2High = false }
           else {
           let steamDeal = SteamDeal(link: link, name: name, releasedate: releasedate, discount: discount, oldPrice: oldPrice, newPrice: newPrice)
           steamDeals.append(steamDeal)
            }
        }
        self.steamDeals = steamDeals
    }
}
