//
//  Shop.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import Foundation

struct Shop: Codable {
    let shopId: Int
    let shopName: String
    let imageUrl: String?
    let menus: [Menu]
    let latitude: Double
    let longitude: Double
    let capacity: Int
    let currentPopulation: Int
}

extension Shop: ModelMockable {
    static var mock: Shop {
        return .init(shopId: 1,
                     shopName: "おみーせ",
                     imageUrl: "https://yahoo.co.jp/icon",
                     menus: [.mock, .mock],
                     latitude: 35.681382,
                     longitude: 139.76608399999998,
                     capacity: 10, currentPopulation: Int.random(in: 0...10)
        )
    }
}
