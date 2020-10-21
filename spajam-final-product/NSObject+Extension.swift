//
//  NSObject+Extension.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/10/21.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: self)
    }
}
