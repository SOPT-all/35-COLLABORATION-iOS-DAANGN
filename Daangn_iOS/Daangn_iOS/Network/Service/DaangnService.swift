//
//  DaangnService.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/26/24.
//

import Foundation

import Moya

final class DaangnService {
    static let shared = DaangnService()
    
    private var homeProvider = MoyaProvider<HomeTargetType>(plugins: [MoyaLoggingPlugin()])
    private var searchProvider = MoyaProvider<SearchTargetType>(plugins: [MoyaLoggingPlugin()])
    private var productProvider = MoyaProvider<ProductTargetType>(plugins: [MoyaLoggingPlugin()])
    
    private init() {}
}

extension DaangnService {
    
    func getProductList(
        categoryList: [String],
        completion: @escaping (NetworkResult<Any>) -> Void)
    {
        homeProvider.request(
            .getProductList(categoryList: categoryList)
        ) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(
                    by: statusCode,
                    data,
                    BaseResponseModel<ProductResponseDTO>.self
                )
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getUserProfile(
        userId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void)
    {
        productProvider.request(
            .getUserProfile(userId: userId)
        ) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(
                    by: statusCode,
                    data,
                    BaseResponseModel<SellerInfoResponseDTO>.self
                )
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
}

// MARK: - Extensions

extension DaangnService {
    
    public func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        
        switch statusCode {
        case 200..<205:
            return isValidData(data: data, T.self)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func isValidData<T: Codable>(data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("⛔️ \(self) 애서 디코딩 오류가 발생했습니다")
            return .pathErr
        }
        
        return .success(decodedData as Any)
    }
}
