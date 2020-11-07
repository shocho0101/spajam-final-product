//
//  URL+queryValue.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/07.
//

import Foundation

extension URL {
    /// 指定したURLクエリパラメーターの値を取得する
    ///
    /// - Parameter key: URLクエリパラメーターのキー
    /// - Returns: 指定したURLクエリパラメーターの値（存在しない場合はnil）
    func queryValue(for key: String) -> String? {
        let queryItems = URLComponents(string: absoluteString)?.queryItems
        return queryItems?.filter { $0.name == key }.compactMap { $0.value }.first
    }
}

