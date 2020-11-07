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
    
    func startPayment() {
        let merchentID = ""
        let request = PKPaymentRequest()
        request.countryCode = "JP"
        request.currencyCode = "JPY"
        request.merchantIdentifier = merchentID
        request.supportedNetworks = paymentNetworkToSupport
        request.merchantCapabilities = .capability3DS
        
    }
}
