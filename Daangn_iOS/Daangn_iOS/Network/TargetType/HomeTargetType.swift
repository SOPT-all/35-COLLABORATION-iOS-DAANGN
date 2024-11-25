//
//  HomeTargetType.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/26/24.
//

import Foundation

import Moya

enum HomeTargetType {
    case getProductList(categoryList: [String])
    case getCategoryList
}

extension HomeTargetType: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.baseURL) else {
            preconditionFailure("유효하지 않는 base URL: \(Config.baseURL)")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getProductList:
            return "/api/home"
        case .getCategoryList:
            return "/api/products/categories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProductList, .getCategoryList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getProductList(let categoryList):
            return .requestParameters(
                parameters: ["category" : categoryList],
                encoding: URLEncoding.queryString
            )
        case .getCategoryList:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
