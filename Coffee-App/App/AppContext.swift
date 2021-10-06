//
//  AppContext.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 14/06/2021.
//

import Foundation
import RealmSwift

class AppContext {
    var realmManager: RealmManager
    var cafesDatasource = [Cafe]()
    var newCafesIDsArray = [String]()
    var firebaseConfigured: Bool = true
    
    init() {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("database.realm")

        realmManager = RealmManager(config: config)
    }
    
}
