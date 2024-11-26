//
//  SearchTargetType.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/26/24.
//

import Foundation

import Moya

enum SearchTargetType {
    case searchProduct(keyword: String)
}

extension SearchTargetType: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.baseURL) else {
            preconditionFailure("유효하지 않는 base URL: \(Config.baseURL)")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .searchProduct:
            return "/api/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchProduct:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .searchProduct(let keyword):
            return .requestParameters(
                parameters: ["keyword" : keyword],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
