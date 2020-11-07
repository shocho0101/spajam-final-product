//
//  ApiTargetType.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/07.
//

import Foundation
import Moya

enum KaikaiAPI: TargetType {
    case getShops
    case getShop(shopId: Int, tableId: Int, deviceId: String)
    
    var baseURL: URL {
        return URL(string: "https://blooming-ravine-19203.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .getShops:
            return "/shop"
        case .getShop(let shopId, _, _):
            return "/shop/\(shopId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getShops:
            return .get
        case .getShop:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getShops:
            return [Shop].jsonMock
        case .getShop:
            return Shop.jsonMock
        }
    }
    
    var task: Task {
        switch self {
        case .getShops:
            return .requestPlain
        case .getShop(_, let tableId, let deviceId):
            return .requestParameters(parameters: ["table_id": tableId, "device_id": deviceId], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}




