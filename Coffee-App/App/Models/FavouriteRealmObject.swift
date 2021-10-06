//
//  FavouriteRealmObject.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 16/06/2021.
//

import Foundation
import RealmSwift

@objcMembers class FavouriteRealmObject: Object {
    dynamic var id: String?
    dynamic var title: String?
    dynamic var address: String?
    dynamic var labels: String?
    dynamic var cafeDescription: String?
    dynamic var imageLink: String?
    dynamic var websiteLink: String?
    dynamic var lat: String?
    dynamic var lon: String?
    dynamic var phone: String?
    dynamic var image: Data?
    
    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(cafe: Cafe) {
        self.init()
        self.id = cafe.id
        self.title = cafe.title
        self.address = cafe.address
        self.labels = cafe.labels
        self.cafeDescription = cafe.cafeDescription
        self.imageLink = cafe.imageLink
        self.websiteLink = cafe.websiteLink
        self.lat = cafe.lat
        self.lon = cafe.lon
        self.phone = cafe.phone
        self.image = cafe.image
    }
    
    func asCafe() -> Cafe {
        let cafe = Cafe()
        cafe.id = self.id
        cafe.title = self.title
        cafe.address = self.address
        cafe.labels = self.labels
        cafe.cafeDescription = self.cafeDescription
        cafe.imageLink = self.imageLink
        cafe.websiteLink = self.websiteLink
        cafe.lat = self.lat
        cafe.lon = self.lon
        cafe.phone = self.phone
        cafe.image = self.image

        return cafe
    }
}
