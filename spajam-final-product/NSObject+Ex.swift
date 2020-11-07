//
//  NSObject+Ex.swift
//  spajam-product
//
//  Created by Fumiya Tanaka on 2020/10/10.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: self)
    }
}
