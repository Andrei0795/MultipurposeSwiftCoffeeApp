//
//  UITableViewCell+Utils.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 14/06/2021.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func register(to tableView: UITableView) {
        let nibFile = UINib(nibName: identifier, bundle: nil)
        tableView.register(nibFile, forCellReuseIdentifier: identifier)
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func register(to collectionView: UICollectionView) {
        let nibFile = UINib(nibName: identifier, bundle: nil)
        collectionView.register(nibFile, forCellWithReuseIdentifier: identifier)
    }
}
