//
//  Menu.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import Foundation

struct Menu: Codable {
    let menuId: Int
    let price: Int
    let menuName: String
    let imageUrl: String
}

extension Menu: ModelMockable {
    static var mock: Menu {
        return .init(menuId: 1, price: 1, menuName: "ごはーん", imageUrl: "https://placehold.jp/150x150.png")
    }
}
