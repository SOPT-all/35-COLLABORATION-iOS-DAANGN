//
//  RelatedSearchWordModel.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/27/24.
//

import Foundation

struct RelatedSearchWordModel {
    let title: String
}

extension RelatedSearchWordModel {
    static func mockData() -> [RelatedSearchWordModel] {
        return [
            RelatedSearchWordModel(title: "아모멘토"),
            RelatedSearchWordModel(title: "렉토 코트"),
            RelatedSearchWordModel(title: "렉토 자켓"),
            RelatedSearchWordModel(title: "렉토 맨투맨"),
            RelatedSearchWordModel(title: "렉토 맨투맨")
        ]
    }
}

