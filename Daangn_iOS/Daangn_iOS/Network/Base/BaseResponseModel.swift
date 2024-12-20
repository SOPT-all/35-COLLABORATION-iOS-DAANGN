//
//  BaseResponseModel.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/16/24.
//

import Foundation

struct BaseResponseModel<T: Codable>: Codable {
    let status: Int
    let message: String?
    let result: T?
}
