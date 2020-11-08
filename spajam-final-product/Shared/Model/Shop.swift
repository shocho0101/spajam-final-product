//
//  Shop.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import Foundation

struct ShopGuide: Codable {
    let shopId: Int
    let shopName: String
    let guides: [Guide]
    let latitude: Double
    let longitude: Double
    let capacity: Int
    let currentPopulation: Int
    
    struct Guide: Codable {
        let imageUrl: String
        let title: String
        let description: String
    }
}

struct Shop: Codable {
    let shopId: Int
    let shopName: String
    let menus: [Menu]
    let latitude: Double
    let longitude: Double
    let capacity: Int
    let currentPopulation: Int
}

extension ShopGuide: ModelMockable {
    static var mock: ShopGuide {
        return .init(shopId: 1,
                     shopName: "おみーせ",
                     guides: [
                        ShopGuide.Guide(
                            imageUrl: "https://yahoo.co.jp/icon",
                            title: "姫路城の歴史",
                            description: "1956年に行われた「昭和の大修理」まで、姫路城はずっと傾いて建っていました。"
                        )
                     ],
                     latitude: 35.681382,
                     longitude: 139.76608399999998,
                     capacity: 10, currentPopulation: Int.random(in: 0...10)
        )
    }
}

extension Shop: ModelMockable {
    static var mock: Shop {
        return .init(shopId: 1,
                     shopName: "おみーせ",
                     imageUrl: "https://s3-ap-northeast-1.amazonaws.com/tabi-channel/upload_by_admin/kinkakuzi_0_800.jpg",
                     menus: [.mock, .mock],
                     latitude: 35.681382,
                     longitude: 139.76608399999998,
                     capacity: 10, currentPopulation: Int.random(in: 0...10)
        )
    }
}
