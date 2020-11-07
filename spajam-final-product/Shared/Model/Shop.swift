//
//  Shop.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import Foundation

struct Shop {
    
    struct Menu: Codable {
        let shopId: String
        let shopName: String
        let menus: [Menu]
    }
    
    struct Map: Codable {
        let shopId: String
        let shopName: String
        let latitude: Double
        let longitude: Double
        let capacity: Int
        let currentPopulation: Int
    }
}
