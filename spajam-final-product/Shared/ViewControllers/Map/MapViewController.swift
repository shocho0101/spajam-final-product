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
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = "地図"
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        for view in mapView.subviews {
            if view.frame.width < 100 {
                view.isHidden = true
            }
        }

        getData()
        
//        let shop1 = Shop(shopId: 0,
//                         shopName: "おみーせ１",
//                         imageUrl: "https://s3-ap-northeast-1.amazonaws.com/tabi-channel/upload_by_admin/kinkakuzi_0_800.jpg",
//                         menus: [],
//                         latitude: 35.657319,
//                         longitude: 139.701533,
//                         capacity: 100,
//                         currentPopulation: 10)
//        setMapPin(shop: shop1)
//        
//        let shop2 = Shop(shopId: 0,
//                         shopName: "おみーせ2",
//                         imageUrl: "https://s3-ap-northeast-1.amazonaws.com/tabi-channel/upload_by_admin/kinkakuzi_0_800.jpg",
//                         menus: [],
//                         latitude: 35.656420,
//                         longitude: 139.701530,
//                         capacity: 100,
//                         currentPopulation: 50)
//        setMapPin(shop: shop2)
//        
//        let shop3 = Shop(shopId: 0,
//                         shopName: "おみーせ3",
//                         imageUrl: "https://s3-ap-northeast-1.amazonaws.com/tabi-channel/upload_by_admin/kinkakuzi_0_800.jpg",
//                         menus: [],
//                         latitude: 35.658210,
//                         longitude: 139.701331,
//                         capacity: 100,
//                         currentPopulation: 80)
//        setMapPin(shop: shop3)
        
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
        self.cardView.setShop(shop: shop)
    }
    
    func showCardView() {
        self.cardView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, options: [.transitionCrossDissolve,.curveEaseInOut],animations: {
            self.cardView.alpha = 1
        })
    }
    
    func unShowCardView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.transitionCrossDissolve,.curveEaseInOut],animations: {
            self.cardView.alpha = 0
        }, completion: {_ in
            self.cardView.isHidden = true
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

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            let mk = MKAnnotationView()
            let imageView = UIImageView()
            imageView.image = #imageLiteral(resourceName: "gps")
            imageView.center = mk.center
            imageView.frame.size = CGSize(width: 25, height: 25)
            mk.addSubview(imageView)
            return mk
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
        annotationView.frame = CGRect(x: 0, y: 0, width: 110, height: 32)
        annotationView.addSubview(view)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let view = view.annotation as? ShopMapAnnotation {
            if cardView.isHidden {
                showCardView()
            }
            setCardView(shop: view.shop)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//        unShowCardView()
    }
    
    
}
