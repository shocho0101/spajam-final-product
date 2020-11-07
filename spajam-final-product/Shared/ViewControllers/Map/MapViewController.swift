//
//  MapViewController.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/07.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager!.requestWhenInUseAuthorization()
    }
    
    func setCurrentLocation() {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: span)
        mapView.region = region
    }
    
    func getData() {
        let action = DataGateway.getAction(GetShopsDataGatewayAction.self)
        
        action.elements.subscribe { shop in
            shop.
        }.disposed(by: disposeBag)

    }
    
    @IBAction func currentButtonTap() {
        setCurrentLocation()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            setCurrentLocation()
            break
        default:
            break
        }
    }
}
