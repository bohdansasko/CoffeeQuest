//
//  MapPin.swift
//  CoffeeQuest
//

import MapKit

class MapPin: NSObject {
    let coordinate: CLLocationCoordinate2D
    let name: String
    let rating: Double
    
    init(coordinate: CLLocationCoordinate2D, name: String, rating: Double) {
        self.coordinate = coordinate
        self.name = name
        self.rating = rating
    }
    
}

extension MapPin: MKAnnotation {
    var title: String? {
        return name
    }
}
