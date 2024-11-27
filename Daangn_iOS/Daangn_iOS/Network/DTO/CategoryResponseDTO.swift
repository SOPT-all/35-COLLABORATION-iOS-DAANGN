//
//  CategoryResponseDTO.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/24/24.
//

import Foundation

struct CategoryResponseDTO: Codable {
    let name: String

    static let sampleCategories: [CategoryResponseDTO] = [
        CategoryResponseDTO(name: "디지털기기"),
        CategoryResponseDTO(name: "가구/인테리어"),
        CategoryResponseDTO(name: "유아동"),
        CategoryResponseDTO(name: "여성의류"),
        CategoryResponseDTO(name: "여성잡화"),
        CategoryResponseDTO(name: "남성패션/잡화"),
        CategoryResponseDTO(name: "생활가전"),
        CategoryResponseDTO(name: "생활/주방"),
        CategoryResponseDTO(name: "스포츠/레저"),
        CategoryResponseDTO(name: "취미/게임/음반"),
        CategoryResponseDTO(name: "뷰티/미용"),
        CategoryResponseDTO(name: "식물"),
        CategoryResponseDTO(name: "가공식품"),
        CategoryResponseDTO(name: "건강기능식품"),
        CategoryResponseDTO(name: "반려동물용품"),
        CategoryResponseDTO(name: "티켓/교환권"),
        CategoryResponseDTO(name: "도서"),
        CategoryResponseDTO(name: "유아도서"),
        CategoryResponseDTO(name: "기타 중고물품"),
        CategoryResponseDTO(name: "삽니다")
    ]
}
