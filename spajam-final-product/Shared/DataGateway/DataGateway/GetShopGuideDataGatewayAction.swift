//
//  GetShopGuideDataGatewayAction.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/08.
//

import Foundation
import Action
import RxMoya
import Moya

struct GetShopGuideDataGatewayAction: DataGatewayAction {
    struct Input {
        var shopId: Int
        let tableId: Int = 2
        var deviceId: String
    }
    
    static func action() -> Action<Input, ShopGuide> {
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
                .map(ShopGuide.self, using: decoder)
                .debug()
                .asObservable()
        }
    }
    
}

extension GetShopGuideDataGatewayAction: DataGatewayMockable {
    static func mock() -> Action<Input, ShopGuide> {
        let provider = MoyaProvider<KaikaiAPI>(stubClosure: { _ -> StubBehavior in
            .delayed(seconds: 2)
        })
        
        return .init { input in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return provider.rx
                .request(.getShop(shopId: input.shopId, tableId: input.tableId, deviceId: input.deviceId))
                .map { data in
                    print(try! JSONSerialization.jsonObject(with: data.data, options: []))
                    return data
                }
                .do(onSuccess: { response in
                    print(response)
                })
                .map(ShopGuide.self, using: decoder)
                .debug()
                .asObservable()
        }
    }
}
