//
//  PayService.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import Foundation
import PassKit

final class PayService {
    var paymentNetworkToSupport: [PKPaymentNetwork] = PKPaymentRequest.availableNetworks()
    
    func isApplePayAvailable() -> Bool {
        PKPaymentAuthorizationViewController.canMakePayments()
    }
    
    func isPaymentNetworksAvailable() -> Bool {
        return PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworkToSupport)
    }
    
    private func buildPaymentRequest() -> PKPaymentRequest {
        let merchentID = "merchant.com.litech.spajam-final-product.aa"
        let request = PKPaymentRequest()
        request.countryCode = "JP"
        request.currencyCode = "JPY"
        request.merchantIdentifier = merchentID
        request.supportedNetworks = paymentNetworkToSupport
        request.merchantCapabilities = .capability3DS
        
        let item = PKPaymentSummaryItem(label: "メニュー1", amount: 1)
        request.paymentSummaryItems = [item]
        return request
    }
    
    func showPaymentViewController(on viewController: UIViewController) {
        let paymentController = PKPaymentAuthorizationViewController(paymentRequest: buildPaymentRequest())
        
    }
}
