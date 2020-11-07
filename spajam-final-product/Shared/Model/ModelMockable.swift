//
//  ModelMockable.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/05.
//

import Foundation

protocol ModelMockable {
    static var mock: Self { get }
    static var jsonMock: Data { get }
}

extension ModelMockable where Self: Encodable {
    static var jsonMock: Data {
        return try! JSONEncoder().encode(mock)
    }
}
