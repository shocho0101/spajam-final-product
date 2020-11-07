//
//  DataGateway.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/05.
//

import Foundation
import RxCocoa
import RxSwift
import Action

enum DataGateway {
    
    static func getAction<T: DataGatewayAction>(_ request: T.Type) -> Action<T.Input, T.Output> {
        return T.action()
    }
    
    static func getAction<T: DataGatewayMockable>(_ request: T.Type, useMock: Bool =  false) -> Action<T.Input, T.Output> {
        if useMock {
            return T.mock()
        } else {
            return T.action()
        }
    }
}


