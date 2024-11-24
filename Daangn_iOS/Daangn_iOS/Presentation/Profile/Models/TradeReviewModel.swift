//
//  TradeReviewModel.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/25/24.
//

import Foundation

struct TradeReviewModel {
    let profileImage: String?
    let nickname: String
    let userType: String
    let address: String
    let writingTime: String
    let content: String
}

enum UserType: String, CaseIterable {
    case seller = "판매자"
    case buyer = "구매자"
}

extension TradeReviewModel {
    static func mockData() -> [TradeReviewModel] {
        [
            TradeReviewModel(
                profileImage: nil,
                nickname: "콤콤",
                userType: UserType.seller.rawValue,
                address: "서울특별시 은평구",
                writingTime: "4개월 전",
                content: "강아지와 여행 잘 다녀오세요:-)"
            ),
            TradeReviewModel(
                profileImage: nil,
                nickname: "피유우우웅",
                userType: UserType.buyer.rawValue,
                address: "강동구 둔촌동",
                writingTime: "7개월 전",
                content: "잘 입을게요  이쁘네요^^"
            ),
            TradeReviewModel(
                profileImage: nil,
                nickname: "범고래",
                userType: UserType.buyer.rawValue,
                address: "송파구 삼전동",
                writingTime: "7개월 전",
                content: "감사합니다. 좋은 저녁 되세요!"
            ),
        ]
    }
}
