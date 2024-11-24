//
//  ProfileModel.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import Foundation

struct ProfileModel {
    let image: String
    let nickname: String
}

extension ProfileModel {
    static func mockData() -> ProfileModel {
        ProfileModel(image: "img_boongabbang", nickname: "밀크티")
    }
}
