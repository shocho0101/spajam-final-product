//
//  DataGatewayAction.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/05.
//

import Foundation
import RxSwift
import RxCocoa
import Action

protocol DataGatewayAction {
    associatedtype Input
    associatedtype Output
    
    static func action() -> Action<Input, Output>
}

protocol DataGatewayMockable: DataGatewayAction {
    static func mock() -> Action<Input, Output>
}
