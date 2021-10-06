//
//  CafeListCellViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import Foundation

enum ActionType {
    case about
    case favourites
    case gallery
}

class HomeActionCellViewModel: HomeCollectionCellViewModelProtocol {
    private var type: ActionType
    var title: String {
        switch type {
        case .about:
            return "About"
        case .favourites:
            return "Favorites"
        case .gallery:
            return "Gallery"
        }
    }
    
    var imageString: String {
        switch type {
        case .about:
            return "about"
        case .favourites:
            return "savedItems"
        case .gallery:
            return "gallery"
        }
    }
    
    init(type: ActionType) {
        self.type = type
    }
}
