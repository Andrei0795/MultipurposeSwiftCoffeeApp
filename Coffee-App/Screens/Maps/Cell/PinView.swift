//
//  PinView.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 15/06/2021.
//

import Foundation
import MapKit


class PinView: NSObject, MKAnnotation {
    let type: CafeType
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    var image: UIImage? {
        switch type {
        case .favourite:
            return UIImage.init(named: "starSmall")
        case .organic:
            return UIImage.init(named: "organicSmall")
        case .normal:
            return UIImage.init(named: "coffeeSmall")
        }
    }

    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, type: CafeType) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.type = type
        super.init()
    }
}
