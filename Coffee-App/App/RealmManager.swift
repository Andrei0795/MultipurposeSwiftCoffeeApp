//
//  RealmManager.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 13/06/2021.
//

import RealmSwift

class RealmManager {
    private var configuration: Realm.Configuration
    
    init(config: Realm.Configuration) {
        self.configuration = config
    }
    
    private func configureRealm() -> Realm? {
        do {
            return try Realm(configuration: configuration)
        } catch {
            print("Error creating realm")
        }
        return nil
    }
    
    func getCafeObjects() -> Results<CafeRealmObject>? {
        guard let realm = configureRealm() else {
            print("Error")
            return nil
        }
        return realm.objects(CafeRealmObject.self)
    }
    
    func getFavouriteObjects() -> Results<FavouriteRealmObject>? {
        guard let realm = configureRealm() else {
            print("Error")
            return nil
        }
        return realm.objects(FavouriteRealmObject.self)
    }
    
    func getMemoryObjects() -> Results<MemoryRealmObject>? {
        guard let realm = configureRealm() else {
            print("Error")
            return nil
        }
        return realm.objects(MemoryRealmObject.self)
    }
    
    func getFavouriteObject(cafe: Cafe) -> FavouriteRealmObject? {
        guard let realm = configureRealm() else {
            print("Error")
            return nil
        }
        return realm.object(ofType: FavouriteRealmObject.self, forPrimaryKey: cafe.id)
    }
    
    func getMemoryObject(memory: Memory) -> MemoryRealmObject? {
        guard let realm = configureRealm() else {
            print("Error")
            return nil
        }
        return realm.object(ofType: MemoryRealmObject.self, forPrimaryKey: memory.id)
    }
    
    func getDatabaseVersion() -> Version? {
        var version: Version?
        guard let realm = configureRealm() else {
            print("Error")
            return nil
        }
        
        let key = Version.uniqueKey
        version = realm.object(ofType: Version.self, forPrimaryKey: key)
        return version
    }
    
    func saveOrUpdateCafeObject(object: CafeRealmObject) {
        guard let realm = configureRealm() else {
            print("Error saveOrUpdateCafeObject")
            return
        }
        
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print("Error saveOrUpdateCafeObject")
        }
    }
    
    func saveFavouriteObject(object: FavouriteRealmObject) {
        guard let realm = configureRealm() else {
            print("Error saveFavouriteObject")
            return
        }
        
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error saveFavouriteObject")
        }
    }
    
    func saveMemoryObject(object: MemoryRealmObject) {
        guard let realm = configureRealm() else {
            print("Error saveFavouriteObject")
            return
        }
        
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error saveFavouriteObject")
        }
    }
    
    func deleteFavouriteObject(object: FavouriteRealmObject) {
        guard let realm = configureRealm() else {
            print("Error deleteFavouriteObject")
            return
        }
        
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleteFavouriteObject")
        }
    }
    
    func deleteMemoryObject(object: MemoryRealmObject) {
        guard let realm = configureRealm() else {
            print("Error deleteFavouriteObject")
            return
        }
        
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleteFavouriteObject")
        }
    }
    
    func saveOrUpdateDatabaseVersion(versionNumber: Double) {
        let version = Version()
        version.versionNumber = versionNumber
        
        guard let realm = configureRealm() else {
            print("Error saveOrUpdateDatabaseVersion")
            return
        }
        
        do {
            try realm.write {
                realm.add(version, update: .modified)
            }
        } catch {
            print("Error saveOrUpdateDatabaseVersion")
        }
    }
}
