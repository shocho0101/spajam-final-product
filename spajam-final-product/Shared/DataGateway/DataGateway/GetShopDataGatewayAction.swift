//
//  GetShopDataGatewayAction.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/07.
//

import Foundation
import Action
import RxSwift
import Moya
import RxMoya

struct GetShopDataGatewayAction: DataGatewayAction {
    struct Input {
        var shopId: Int
        var tableId: Int
        var deviceId: String
    }
    
    static func action() -> Action<Input, Shop> {
        let provider = MoyaProvider<KaikaiAPI>(stubClosure: { _ -> StubBehavior in
            .never
        })
        
        return .init { input in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return provider.rx
                .request(.getShop(shopId: input.shopId, tableId: input.tableId, deviceId: input.deviceId))
                .do(onSuccess: { response in
                    print(response)
                })
                .map(Shop.self, using: decoder)
                .debug()
                .asObservable()
        }
    }
    
}

extension GetShopDataGatewayAction: DataGatewayMockable {
    static func mock() -> Action<Input, Shop> {
        let provider = MoyaProvider<KaikaiAPI>(stubClosure: { _ -> StubBehavior in
            .delayed(seconds: 2)
        })
        
        return .init { input in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return provider.rx
                .request(.getShop(shopId: input.shopId, tableId: input.tableId, deviceId: input.deviceId))
                .do(onSuccess: { response in
                    print(response)
                })
                .map(Shop.self, using: decoder)
                .debug()
                .asObservable()
        }
    }
}

