//
//  MainTabBarController.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstItem = self.tabBar.items?[0]
        firstItem?.image = UIImage(named: "home")
        firstItem?.title = "Home"

        let secondItem = self.tabBar.items?[1]
        secondItem?.image = UIImage(named: "maps")
        secondItem?.title = "Cafe Map"

        let thirdItem = self.tabBar.items?[2]
        thirdItem?.image = UIImage(named: "list")
        thirdItem?.title = "Cafe List"
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    
}
