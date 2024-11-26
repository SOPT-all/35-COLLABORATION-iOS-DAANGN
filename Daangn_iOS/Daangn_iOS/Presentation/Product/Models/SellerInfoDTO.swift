//
//  SellerInfoDTO.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/26/24.
//

struct SellerInfo {
    let userId: Int
    let nickname: String
    let profileImage: String
    let address: String
}

extension SellerInfo {
    
    static let sellerInfo: SellerInfo = SellerInfo(userId: 1, nickname: "헿헿", profileImage: "img_user_sm", address: "송파구 삼전동")
}
