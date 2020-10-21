//
//  DataGateway.swift
//  spajam-product
//
//  Created by 張翔 on 2020/10/10.
//

import Foundation
import RxCocoa
import RxSwift
import Action

enum DataGateway {
    
    static func getAction<T: DataGatewayAction>(_ request: T.Type) -> Action<T.Input, T.Output> {
        return request.action()
    }
}
