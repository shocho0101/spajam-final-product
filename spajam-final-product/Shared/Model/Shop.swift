//
//  Shop.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import Foundation

struct Shop: Codable {
    let shopId: String
    let shopName: String
    let menus: [Menu]
    let latitude: Double
    let longitude: Double
    let capacity: Int
    let currentPopulation: Int
}

extension Shop: ModelMockable {
    static var mock: Shop {
        return .init(shopId: "aaaa",
                     shopName: "おみーせ",
                     menus: [.mock, .mock],
                     latitude: 35.681382,
                     longitude: 139.76608399999998,
                     capacity: 100, currentPopulation: 25
        )
    }
}
