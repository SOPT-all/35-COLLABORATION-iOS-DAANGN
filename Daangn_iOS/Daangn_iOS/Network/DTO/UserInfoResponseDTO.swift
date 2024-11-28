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
