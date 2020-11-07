//
//  Menu.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import Foundation

struct Menu: Codable {
    let menuId: String
    let price: Int
    let menuName: String
}

extension Menu: ModelMockable {
    static var mock: Menu {
        return .init(menuId: "fffff", price: 999, menuName: "ごはーん")
    }
}
