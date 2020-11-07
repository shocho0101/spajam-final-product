//
//  PayService.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import Foundation
import RxSwift
import RxCocoa
import PassKit

final class PayService: NSObject {
    let paymentNetworkToSupport: [PKPaymentNetwork] = PKPaymentRequest.availableNetworks()
    
    private let didSuccessPaymentServiceRelay: PublishRelay<Void> = .init()
    
    private weak var viewController: PKPaymentAuthorizationViewController?
    
    var didSuccessPaymentService: Observable<Void> {
        didSuccessPaymentServiceRelay.asObservable()
    }
    
    func isApplePayAvailable() -> Bool {
        PKPaymentAuthorizationViewController.canMakePayments()
    }
    
    func isPaymentNetworksAvailable() -> Bool {
        return PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworkToSupport)
    }
    
    private func buildPaymentRequest(items: [(menu: Menu, count: Int)]) -> PKPaymentRequest {
        let merchentID = "merchant.com.litech.spajam-final-product.aa"
        let request = PKPaymentRequest()
        request.countryCode = "JP"
        request.currencyCode = "JPY"
        request.merchantIdentifier = merchentID
        request.supportedNetworks = paymentNetworkToSupport
        request.merchantCapabilities = .capability3DS
        
        let items = items.map { (menu, count) in
            PKPaymentSummaryItem(label: menu.menuName, amount: NSDecimalNumber(value: count))
        }
        request.paymentSummaryItems = items
        return request
    }
    
    func showPaymentViewController(on viewController: UIViewController, items: [(menu: Menu, count: Int)]) {
        guard let paymentController = PKPaymentAuthorizationViewController(paymentRequest: buildPaymentRequest(items: items)) else {
            return
        }
        paymentController.delegate = self
        viewController.present(paymentController, animated: true, completion: nil)
        self.viewController = paymentController
    }
}

extension PayService: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        viewController?.dismiss(animated: true, completion: nil)
        didSuccessPaymentServiceRelay.accept(())
    }
}
