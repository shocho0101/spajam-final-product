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
    @IBOutlet var cardView: CardView!
    
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
        let ba = BalloonView()
        ba.center = view.center
        ba.frame = CGRect(x: 50, y: 50, width: 100, height: 50)
        view.addSubview(ba)
        cardView.isHidden = true
        getData()
    }
    
    func setCurrentLocation() {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: span)
        mapView.region = region
    }
    
    func getData() {
        action.execute(1)
            .subscribe( onNext:{
                $0.map{
                    self.setMapPin(shop: $0)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setMapPin(shop: Shop) {
        let coordinate = mapView.userLocation.coordinate
        let pin = MKPointAnnotation()
        pin.title = shop.shopName
        pin.subtitle = shop.capacity.description
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    
    func setCardView(shop:Shop) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCrossDissolve, animations: {
            self.cardView.isHidden = false
            self.cardView.setShop(shop: shop)
        })
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
