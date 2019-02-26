//
//  ViewController+MKMapViewDelegate.swift
//  CoffeeQuest
//
//  Created by Bogdan Sasko on 2/26/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import MapKit

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        centerMap(on: userLocation.coordinate)
    }
    
    private func centerMap(on coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 3000
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
