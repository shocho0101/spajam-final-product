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
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cardView: CardView!
    
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
        let pin = ShopMapAnnotation(shop: shop)
        pin.title = shop.shopName
        pin.subtitle = shop.capacity.description
        pin.coordinate = CLLocationCoordinate2D(latitude: shop.latitude, longitude: shop.longitude)
        mapView.addAnnotation(pin)
    }
    
    func setCardView(shop:Shop) {
        UIView.animate(withDuration: 1.0) {
            self.cardView.isHidden = false
            self.cardView.setShop(shop: shop)
        }
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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(with: annotation.shop)
        annotationView.frame = CGRect(x: 0, y: 0, width: 93, height: 16)
        annotationView.addSubview(view)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let view = view.annotation as? ShopMapAnnotation {
            setCardView(shop: view.shop)
        }
    }
}
