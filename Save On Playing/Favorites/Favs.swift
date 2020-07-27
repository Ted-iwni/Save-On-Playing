//
//  Favs.swift
//  Save On Playing
//
//  Created by Ted Vyushkin on 21/06/2020.
//  Copyright © 2020 Ted Inc. All rights reserved.
//

import Foundation

struct Favorites: Codable{
    var Link: String
    var Name: String
    var Disc: String
    var OldP: String
    var NewP: String
}

let Link = "https://www.epicgames.com/store/ru/free-games"
let Name = "Название продукта"
let Disc = "Скидка"
let OldP = "Старая цена"
let NewP = "Новая цена"

var Favs = [Favorites(Link: Link, Name: Name, Disc: Disc, OldP: OldP, NewP: NewP)]

func addFav(favLink: String, favName: String, favDisc: String, favOP: String, favNP: String){
    Favs.append(Favorites.init(Link: favLink, Name: favName, Disc: favDisc, OldP: favOP, NewP: favNP))
    saveData()
}

func removeFav(at index: Int){
    Favs.remove(at: index)
    saveData()
}

func saveData(){
   if let encodedFavorites = try? JSONEncoder().encode(Favs){
    UserDefaults.standard.set(encodedFavorites, forKey: "FavsKey")
    }
    UserDefaults.standard.synchronize()
}

func loadData(){
    if let savedFavs = UserDefaults.standard.object(forKey: "FavsKey") as? Data {
        if let loadedFavs = try? JSONDecoder().decode(Favorites.self, from: savedFavs){
            Favs.append(Favorites.init(Link: loadedFavs.Link, Name: loadedFavs.Name, Disc: loadedFavs.Disc, OldP: loadedFavs.OldP, NewP: loadedFavs.NewP))
        }
      }
    }

