//
//  HomeTagResponseDTO.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/20/24.
//

import Foundation

struct HomeTagResponseDTO: Hashable {
    let id: UUID = UUID()
    let title: String

    static let sampleTags: [HomeTagResponseDTO] = [
        HomeTagResponseDTO(title: "가락2동 외 59"),
        HomeTagResponseDTO(title: "가격"),
        HomeTagResponseDTO(title: "카테고리"),
        HomeTagResponseDTO(title: "정렬"),
        HomeTagResponseDTO(title: "추천"),
        HomeTagResponseDTO(title: "인기"),
        HomeTagResponseDTO(title: "최신"),
        HomeTagResponseDTO(title: "거리순"),
        HomeTagResponseDTO(title: "채팅"),
        HomeTagResponseDTO(title: "좋아요")
    ]
}

