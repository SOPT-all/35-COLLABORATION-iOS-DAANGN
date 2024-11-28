//
//  SellerInfoResponseDTO.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/26/24.
//

struct SellerInfoResponseDTO: Codable {
    let user_id: Int
    let nickname: String
    let profile_image: String?
    let address: String
}
//
extension SellerInfoResponseDTO {
    
    static let sampleSellerInfo: SellerInfoResponseDTO = SellerInfoResponseDTO(user_id: 1, nickname: "헿헿", profile_image: "img_user_sm", address: "송파구 삼전동")
}
