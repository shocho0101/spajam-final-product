//
//  ZipCode.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/05.
//

import Foundation

struct ZipCode: Codable {
    var status: Int
    var message: String?
}

extension ZipCode: ModelMockable {
    static var mock: ZipCode {
        return .init(status: 200, message: "モックだよ")
    }
}
