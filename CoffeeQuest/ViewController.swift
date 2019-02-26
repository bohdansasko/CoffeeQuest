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

