//
//  AppDelegate.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 08/06/2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appContext: AppContext!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        appContext = AppContext()
        
        //In order to configure Firebase, you must create your own app in the firebase console and populate GoogleService-Info.plist with the relevant app data
        //You also need to make sure cafes.json is imported in the realtime database section of Firebase
        //Be careful at the rules section for the realtime database. You must make sure your access does not expire
        //FirebaseApp.configure() UNCOMMENT THIS IF ALL THE STEPS ABOVE WERE COMPLETED
        appContext.firebaseConfigured = false
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

