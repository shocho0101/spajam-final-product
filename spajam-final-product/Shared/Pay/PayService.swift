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
    
    var didSuccessPaymentService: Observable<Void> {
        didSuccessPaymentServiceRelay.asObservable()
    }
    
    func isApplePayAvailable() -> Bool {
        PKPaymentAuthorizationViewController.canMakePayments()
    }
    
    func isPaymentNetworksAvailable() -> Bool {
        return PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworkToSupport)
    }
    
    private func buildPaymentRequest(menu: Menu) -> PKPaymentRequest {
        let merchentID = "merchant.com.litech.spajam-final-product.aa"
        let request = PKPaymentRequest()
        request.countryCode = "JP"
        request.currencyCode = "JPY"
        request.merchantIdentifier = merchentID
        request.supportedNetworks = paymentNetworkToSupport
        request.merchantCapabilities = .capability3DS
        
        let item = PKPaymentSummaryItem(label: menu.menuName, amount: 1)
        request.paymentSummaryItems = [item]

        return request
    }
    
    func showPaymentViewController(on viewController: UIViewController, menu: Menu) {
        guard let paymentController = PKPaymentAuthorizationViewController(paymentRequest: buildPaymentRequest(menu: menu)) else {
            return
        }
        paymentController.delegate = self
        viewController.present(paymentController, animated: true, completion: nil)
    }
}

extension PayService: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        didSuccessPaymentServiceRelay.accept(())
    }
}
