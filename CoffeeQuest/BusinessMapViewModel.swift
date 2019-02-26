//
//  BusinessMapViewModel.swift
//  CoffeeQuest
//

import MapKit

class BusinessMapViewModel: NSObject {
    let coordinate: CLLocationCoordinate2D
    let name: String
    let rating: Double
    let image: UIImage?
    let ratingDescription: String
    
    init(coordinate: CLLocationCoordinate2D, name: String, rating: Double) {
        self.coordinate = coordinate
        self.name = name
        self.rating = rating
        
        self.ratingDescription = "\(rating) stars"
        
        switch rating {
        case 4.75...5.0: image = UIImage(named: "great")
        case 4.0..<4.75: image = UIImage(named: "good")
        case 3.5..<4.0 : image = UIImage(named: "meh")
        default        : image = UIImage(named: "bad")
        }
    }
    
}

extension BusinessMapViewModel: MKAnnotation {
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return ratingDescription
    }
}
