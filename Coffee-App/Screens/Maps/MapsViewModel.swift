//
//  MapsViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import Foundation
import MapKit

class MapsViewModel {
    
    private var annotationsDatasource = [PinView]()
    var filteredAnnotationsDatasource = [PinView]()

    func setupDatasource() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let cafes = appDelegate.appContext.cafesDatasource
        
        for cafe in cafes {
            if let lat = cafe.lat, let lon = cafe.lon {
                let location = CLLocationCoordinate2D(latitude: Double(lat) ?? 0, longitude: Double(lon) ?? 0)
                let marker = PinView(title: cafe.title ?? "", subtitle: cafe.address ?? "", coordinate: location, type: cafe.type)
                annotationsDatasource.append(marker)
            }
        }
        filteredAnnotationsDatasource = annotationsDatasource
    }
    
    func cancelFilters() {
        filteredAnnotationsDatasource = annotationsDatasource
    }
    
    func filterDatasource(type: CafeType) {
        filteredAnnotationsDatasource = annotationsDatasource
        filteredAnnotationsDatasource = filteredAnnotationsDatasource.filter {
            $0.type == type
        }
    }
}
