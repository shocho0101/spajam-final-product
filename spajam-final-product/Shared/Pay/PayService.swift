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
    
    private func buildPaymentRequest(items: [(menu: Menu, count: Int)], shop: Shop) -> PKPaymentRequest {
        let merchentID = "merchant.com.litech.spajam-final-product.aa"
        let request = PKPaymentRequest()
        request.countryCode = "JP"
        request.currencyCode = "JPY"
        request.merchantIdentifier = merchentID
        request.supportedNetworks = paymentNetworkToSupport
        request.merchantCapabilities = .capability3DS
        
        var paymentItems = items.map { (menu, count) in
            PKPaymentSummaryItem(label: menu.menuName, amount: NSDecimalNumber(value: count * menu.price))
        }
        let totalPrice = items.reduce(into: 0) { $0 += $1.menu.price * $1.count }
        paymentItems.append(PKPaymentSummaryItem(label: shop.shopName, amount: NSDecimalNumber(value: totalPrice)))
        request.paymentSummaryItems = paymentItems
        return request
    }
    
    func showPaymentViewController(on viewController: UIViewController, items: [(menu: Menu, count: Int)], shop: Shop) {
        guard let paymentController = PKPaymentAuthorizationViewController(paymentRequest: buildPaymentRequest(items: items, shop: shop)) else {
            return
        }
        paymentController.delegate = self
        viewController.present(paymentController, animated: true, completion: nil)
    }
}

extension PayService: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        didSuccessPaymentServiceRelay.accept(())
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(.init(status: .success, errors: nil))
    }
}
