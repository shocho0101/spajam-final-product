//
//  ZipCodeAPI.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/05.
//

import Foundation
import Moya

enum ZipCodeAPI: TargetType {
    case search(zipCode: Int)
    
    var baseURL: URL {
        return URL(string: "https://zipcloud.ibsnet.co.jp/api")!
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .search:
            return ZipCode.jsonMock
        }
    }
    
    var task: Task {
        switch self {
        case .search(let zipCode):
            return .requestParameters(parameters: ["zipcode": zipCode], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
