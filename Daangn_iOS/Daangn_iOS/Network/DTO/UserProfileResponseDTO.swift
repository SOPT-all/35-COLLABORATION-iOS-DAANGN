//
//  UserProfileResponseDTO.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/28/24.
//

import Foundation

struct UserProfileResponseDTO: Codable {
    let user_id: Int
    let nickname: String
    let profile_image: String?
    let address: String
}
