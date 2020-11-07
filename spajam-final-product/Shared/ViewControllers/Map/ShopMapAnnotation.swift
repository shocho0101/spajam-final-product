//
//  ShopMapAnnotation.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import Foundation
import UIKit
import MapKit

class ShopMapAnnotation: MKPointAnnotation {
    let shop: Shop
    
    init(shop: Shop) {
        self.shop = shop
        super.init()
    }
}
