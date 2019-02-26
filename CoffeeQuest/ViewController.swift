//
//  ViewController.swift
//  CoffeeQuest
//

import MapKit
import YelpAPI

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.showsUserLocation = true
        }
    }
    
    var businesses: [YLPBusiness] = []
    let client = YLPClient(apiKey: Constants.API_KEY)
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
    }
}

extension ViewController {
    func searchForBusinesses() {
        let userCoordinate = mapView.userLocation.coordinate
        guard !userCoordinate.latitude.isZero && !userCoordinate.longitude.isZero else { return }
        let yelpCoordinate = YLPCoordinate(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        
        client.search(with: yelpCoordinate,
                      term: "coffee",
                      limit: 35,
                      offset: 0, sort: .bestMatched) {
                        [weak self] (searchResult, error) in
                        guard let strongSelf = self else { return }
                        guard let searchResult = searchResult, error == nil else {
                            print("Seach failed: \(String(describing: error))")
                            return
                        }
                        
                        strongSelf.businesses = searchResult.businesses
                        DispatchQueue.main.async {
                            strongSelf.addAnnotations()
                        }
        }
    }
    
    func addAnnotations() {
        for business in businesses {
            guard let ylpCoordinate = business.location.coordinate else {
                continue
            }
            let coordinate = CLLocationCoordinate2D(latitude: ylpCoordinate.latitude,
                                                    longitude: ylpCoordinate.longitude)
            let name = business.name
            let rating = business.rating
            let annotation = BusinessMapViewModel(coordinate: coordinate, name: name, rating: rating)
            
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let viewModel = annotation as? BusinessMapViewModel else {
            return nil
        }
        let identifier = "business"
        let annotationView: MKAnnotationView
        if let existingView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = existingView
        } else {
            annotationView = MKAnnotationView(annotation: viewModel, reuseIdentifier: identifier)
        }
        
        annotationView.image = viewModel.image
        annotationView.canShowCallout = true
        
        return annotationView
    }
}
