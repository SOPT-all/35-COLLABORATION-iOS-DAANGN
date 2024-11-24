//
//  MannerRatingModel.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/25/24.
//

import Foundation

struct MannerRatingModel {
    let ratingCount: Int
    let mannerType: String
}

extension MannerRatingModel {
    static func mockData() -> [MannerRatingModel] {
        [
            MannerRatingModel(ratingCount: 128, mannerType: "친절하고 매너가 좋아요."),
            MannerRatingModel(ratingCount: 104, mannerType: "시간 약속을 잘 지켜요."),
            MannerRatingModel(ratingCount: 98, mannerType: "응답이 빨라요."),
        ]
    }
}
