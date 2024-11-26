//
//  ProductTargetType.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/26/24.
//

import Foundation

import Moya

enum ProductTargetType {
    case getUserProfile(userId: Int)
    case getPostDetails(productId: Int)
    case getUserItemList(userId: Int)
}

extension ProductTargetType: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.baseURL) else {
            preconditionFailure("유효하지 않는 base URL: \(Config.baseURL)")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getUserProfile(let userId):
            return "/api/users/\(userId)"
        case .getPostDetails(let productId):
            return "/api/products/\(productId)"
        case .getUserItemList(let userId):
            return "/api/users/\(userId)/selling-products"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserProfile, .getPostDetails, .getUserItemList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getUserProfile, .getPostDetails, .getUserItemList:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
