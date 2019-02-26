//
//  ViewController+MKMapViewDelegate.swift
//  CoffeeQuest
//

import MapKit
import YelpAPI

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        centerMap(on: userLocation.coordinate)
    }
    
    private func centerMap(on coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 3000
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        searchForBusinesses()
    }
    
    private func searchForBusinesses() {
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
    
    private func addAnnotations() {
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
}
