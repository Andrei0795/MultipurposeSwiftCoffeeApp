//
//  CafeRealmObject.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 13/06/2021.
//

import RealmSwift
import Foundation

@objcMembers class Version: Object {
    static let uniqueKey: String = "DatabaseVersion"
    dynamic var uniqueKey: String = Version.uniqueKey
    dynamic var versionNumber: Double = 0
    
    override class func primaryKey() -> String? {
        return "uniqueKey"
    }
}

@objcMembers class CafeRealmObject: Object {
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
    dynamic var isFavourite: Bool = false
    dynamic var isNew: Bool = false
    
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
        self.isNew = cafe.isNew
        self.isFavourite = cafe.isFavourite
    }
    
    convenience init(dictionary: NSDictionary) {
        self.init()
        self.id = dictionary["id"] as? String
        self.title = dictionary["title"] as? String
        self.address = dictionary["address"] as? String
        self.labels = dictionary["labels"] as? String
        self.cafeDescription = dictionary["description"] as? String
        self.imageLink = dictionary["imagelink"] as? String
        self.websiteLink = dictionary["website"] as? String
        if let lat = dictionary["lat"] as? Double, let lon = dictionary["lon"] as? Double {
            self.lat = String(lat)
            self.lon = String(lon)
        } else {
            self.lat = String(0)
            self.lon = String(0)
        }
        self.phone = dictionary["phone"] as? String
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
        cafe.isFavourite = self.isFavourite
        cafe.isNew = self.isNew
        return cafe
    }
}
