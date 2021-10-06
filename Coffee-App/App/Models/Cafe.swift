//
//  Cafe.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 13/06/2021.
//

import UIKit

enum CafeType {
    case normal
    case organic
    case favourite
}

class Cafe {
    var id: String?
    var title: String?
    var address: String?
    var labels: String?
    var cafeDescription: String?
    var imageLink: String?
    var websiteLink: String?
    var lat: String?
    var lon: String?
    var phone: String?
    var image: Data?
    var isFavourite: Bool = false
    var isNew: Bool = false
    
    var type: CafeType {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.appContext.realmManager.getFavouriteObject(cafe: self) != nil {
            return .favourite
        }
        if let label = labels, label.contains("organic") {
            return .organic
        }
        return .normal
    }
    

    convenience init(id: String?, title: String?, address: String?, labels: String?, cafeDescription: String?, imageLink: String?, websiteLink: String?, lat: String?, lon: String?, phone: String?) {
        self.init()
        self.id = id
        self.title = title
        self.cafeDescription = cafeDescription
        self.imageLink = imageLink
        self.labels = labels
        self.address = address
        self.websiteLink = websiteLink
        self.lat = lat
        self.lon = lon
        self.phone = phone
    }
}
