//
//  DataGatewayAction.swift
//  spajam-product
//
//  Created by 張翔 on 2020/10/10.
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
