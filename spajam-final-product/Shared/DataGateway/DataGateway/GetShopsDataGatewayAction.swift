//
//  GetShopsDataGatewayAction.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/07.
//

import Foundation
import Action
import RxSwift
import Moya
import RxMoya

struct GetShopsDataGatewayAction: DataGatewayAction {
    static func action() -> Action<Int, [Shop]> {
        let provider = MoyaProvider<KaikaiAPI>(stubClosure: { _ -> StubBehavior in
            .never
        })
        
        return .init { zipCode in
            return provider.rx
                .request(.getShops)
                .do(onSuccess: { response in
                    print(response)
                })
                .map([Shop].self)
                .debug()
                .asObservable()
        }
    }
    
}

extension GetShopsDataGatewayAction: DataGatewayMockable {
    static func mock() -> Action<Int, [Shop]> {
        let provider = MoyaProvider<KaikaiAPI>(stubClosure: { _ -> StubBehavior in
            .delayed(seconds: 2)
        })
        
        return .init { zipCode in
            return provider.rx
                .request(.getShops)
                .do(onSuccess: { response in
                    print(response)
                })
                .map([Shop].self)
                .debug()
                .asObservable()
        }
    }
}
