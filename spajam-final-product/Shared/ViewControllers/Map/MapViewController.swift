//
//  MapViewController.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/07.
//
import Foundation
import UIKit
import MapKit
import CoreLocation
import RxSwift
import RxCocoa
import Action

class MapViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let action = DataGateway.getAction(GetShopsDataGatewayAction.self, useMock: true)
    
    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        getData()
        
        guard let location = locationManager.location?.coordinate else {
            return
        }
        mapView.setRegion(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
    }
    
    func setCurrentLocation() {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: span)
        mapView.region = region
    }
    
    func getData() {
        action.execute(1)
            .subscribe( onNext:{
                $0.forEach {
                    self.setMapPin(shop: $0)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setMapPin(shop: Shop) {
        let coordinate = mapView.userLocation.coordinate
        let pin = ShopMapAnnotation(shop: shop)
        pin.title = shop.shopName
        pin.subtitle = shop.capacity.description
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
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

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        guard let annotation = annotation as? ShopMapAnnotation else {
            return nil
        }
        let identifier = "ShopMapAnnotationView"
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        guard let view = UINib(nibName: "ShopMapAnnotationView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ShopAnnotationView
        else {
            return nil
        }
        view.configure(with: annotation.shop)
        annotationView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        annotationView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: annotationView.topAnchor),
            view.bottomAnchor.constraint(equalTo: annotationView.bottomAnchor),
            view.centerXAnchor.constraint(equalTo: annotationView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: annotationView.centerXAnchor)
        ])
        return annotationView
    }
}
