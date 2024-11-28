//
//  UserInfoResponseDTO.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/26/24.
//

struct UserInfoResponseDTO: Codable {
    let user_id: Int
    let nickname: String
    let profile_image: String?
    let address: String
}

extension UserInfoResponseDTO {
    
    static let sampleUserInfo: UserInfoResponseDTO = UserInfoResponseDTO(user_id: 1, nickname: "헿헿", profile_image: "img_user_sm", address: "송파구 삼전동")
}
