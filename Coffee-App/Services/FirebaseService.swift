//
//  FirebaseService.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import Foundation
import FirebaseDatabase

typealias FetchedCafesCallback = () -> [Cafe]?

class FirebaseService {
    
    private var appDelegate: AppDelegate!
    private var ref: DatabaseReference!
    var fetchedNewCafesCallback: FetchedCafesCallback?
    var fetchedAllCafesCallback: FetchedCafesCallback?
    var dataLoaded: (([Cafe]) -> Void)?

    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    init() {
        
    }
    
    func loadData() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        if !appDelegate.appContext.firebaseConfigured {
            fallbackForCafes()
            return
        }
        
        ref = Database.database().reference()
        self.ref.child("version").observeSingleEvent(of: .value, with: {  (snapshot) in
            
            if let version = snapshot.value as? Double {
                print("The version from the database: \(version)")
                                                        
                if self.appDelegate.appContext.realmManager.getDatabaseVersion()?.versionNumber == version {
                    print("The version from the database: \(version) is not new! Will not update Realm!")
                    self.formCafeDatasource()
                } else {
                    self.appDelegate.appContext.realmManager.saveOrUpdateDatabaseVersion(versionNumber: version)
                    self.observeNewCafes()
                }
            }
        })
    }
    
    func observeNewCafes() {
        self.ref.child("newCaffes").observeSingleEvent(of: .value, with: {  (snapshot) in
            
            var newCafesIDsArray = [String]()
            if let newCafes = snapshot.value as? [NSDictionary?] {
                //print("New Cafes: \(newCafes)")
                for newCafe in newCafes {
                    if let newCafe = newCafe, let theID = newCafe["id"] as? String {
                        newCafesIDsArray.append(theID)
                    }
                }
                self.appDelegate.appContext.newCafesIDsArray = newCafesIDsArray
                self.observeAllCafes()
            }
        })
    }
    
    func observeAllCafes() {
        self.ref.child("allCaffes").observeSingleEvent(of: .value, with: { (snapshot) in

            
            if let allCafes = snapshot.value as? [NSDictionary?], allCafes.count > 0 {
                //print("All Cafes: \(allCafes)")
                self.addAllCafesToRealm(dictionaryArray: allCafes)
            }
        })
    }
    
    //Fallback if Firebase is not configured
    func fallbackForCafes() {
        if self.appDelegate.appContext.realmManager.getDatabaseVersion()?.versionNumber == 0.1 {
            self.formCafeDatasource()
            return
        }
        
        //store fallback version
        self.appDelegate.appContext.realmManager.saveOrUpdateDatabaseVersion(versionNumber: 0.1)

        //get json
        var newCafes: [NSDictionary?]?
        var allCafes: [NSDictionary?]?
        if let path = Bundle.main.path(forResource: "cafes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
                if let newCafes2 = jsonResult?["newCaffes"] as? [Any] {
                    newCafes = [NSDictionary?]()
                    for cafe in newCafes2 {
                        newCafes?.append(cafe as? NSDictionary)
                    }
                }
                if let allCafes2 = jsonResult?["allCaffes"] as? [Any] {
                    allCafes = [NSDictionary?]()
                    for cafe in allCafes2 {
                        allCafes?.append(cafe as? NSDictionary)
                    }
                }

            } catch {
                assertionFailure("This should not happen")
            }
        }
        
        
        //get new cafes (found in json)
        var newCafesIDsArray = [String]()
        if let newCafes = newCafes {
            for newCafe in newCafes {
                if let newCafe = newCafe, let theID = newCafe["id"] as? String {
                    newCafesIDsArray.append(theID)
                }
            }
            self.appDelegate.appContext.newCafesIDsArray = newCafesIDsArray
        }
        
        //get all cafes from json
        if let allCafes = allCafes, allCafes.count > 0 {
            self.addAllCafesToRealm(dictionaryArray: allCafes)
        }
        
    }
    
    func addAllCafesToRealm(dictionaryArray: [NSDictionary?]) {
        for dictionary in dictionaryArray {
            if let dictionary = dictionary {
                let cafeRealmObject = CafeRealmObject(dictionary: dictionary)
                if let theID = cafeRealmObject.id,  appDelegate.appContext.newCafesIDsArray.contains(theID) {
                    cafeRealmObject.isNew = true
                }
                
                appDelegate.appContext.realmManager.saveOrUpdateCafeObject(object: cafeRealmObject)
            }
        }
        formCafeDatasource()
    }
    
    func formCafeDatasource() {
        var newDatasource = [Cafe]()
        guard let realmCafes = appDelegate.appContext.realmManager.getCafeObjects() else {
            assertionFailure("This should not happen")
            return
        }
        
        for realmCafe in realmCafes {
            newDatasource.append(realmCafe.asCafe())
        }
        
        appDelegate.appContext.cafesDatasource = newDatasource
        let newCafes = newDatasource.filter {
            $0.isNew
        }
        //print(appDelegate.appContext.cafesDatasource)
        dataLoaded?(newCafes)
    }
}
