//
//  ViewController.swift
//  CoffeeQuest
//
//  Created by Bogdan Sasko on 2/26/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import MapKit
import YelpAPI

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.showsUserLocation = true
        }
    }
    
    var business: [YLPBusiness] = []
    let client = YLPClient(apiKey: Constants.API_KEY)
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
    }
}

