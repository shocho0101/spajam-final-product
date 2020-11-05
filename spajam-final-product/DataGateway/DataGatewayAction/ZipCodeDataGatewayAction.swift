//
//  ZipCodeDataGatewayAction.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/05.
//

import Foundation
import Action
import RxSwift
import Moya
import RxMoya

struct ZipCodeDataAction: DataGatewayAction {
    static func action() -> Action<Int, ZipCode> {
        let provider = MoyaProvider<ZipCodeAPI>(stubClosure: { _ -> StubBehavior in
            .never
        })
        
        return .init { zipCode in
            return provider.rx
                .request(.search(zipCode: 1010001))
                .do(onSuccess: { response in
                    print(response)
                })
                .map(ZipCode.self)
                .debug()
                .asObservable()
        }
    }
    
}

extension ZipCodeDataAction: DataGatewayMockable {
    static func mock() -> Action<Int, ZipCode> {
        let provider = MoyaProvider<ZipCodeAPI>(stubClosure: { _ -> StubBehavior in
            .delayed(seconds: 1)
        })
        
        return .init { zipCode in
            return provider.rx
                .request(.search(zipCode: 1010001))
                .do(onSuccess: { response in
                    print(response)
                })
                .map(ZipCode.self)
                .debug()
                .asObservable()
        }
    }
}
