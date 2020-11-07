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
    
    var baseURL: URL {
        return URL(string: "https://kaikai.com/api")!
    }
    
    var path: String {
        switch self {
        case .getShops:
            return "/shops"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getShops:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getShops:
            return [Shop].jsonMock
        }
    }
    
    var task: Task {
        switch self {
        case .getShops:
        return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}




