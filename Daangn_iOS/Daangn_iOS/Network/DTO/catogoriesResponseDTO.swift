//
//  CategoryResponseDTO.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/24/24.
//

import Foundation

struct catogoriesResponseDTO: Codable {
    let name: String

    static let sampleCategories: [catogoriesResponseDTO] = [
        catogoriesResponseDTO(name: "디지털기기"),
        catogoriesResponseDTO(name: "가구/인테리어"),
        catogoriesResponseDTO(name: "유아동"),
        catogoriesResponseDTO(name: "여성의류"),
        catogoriesResponseDTO(name: "여성잡화"),
        catogoriesResponseDTO(name: "남성패션/잡화"),
        catogoriesResponseDTO(name: "생활가전"),
        catogoriesResponseDTO(name: "생활/주방"),
        catogoriesResponseDTO(name: "스포츠/레저"),
        catogoriesResponseDTO(name: "취미/게임/음반"),
        catogoriesResponseDTO(name: "뷰티/미용"),
        catogoriesResponseDTO(name: "식물"),
        catogoriesResponseDTO(name: "가공식품"),
        catogoriesResponseDTO(name: "건강기능식품"),
        catogoriesResponseDTO(name: "반려동물용품"),
        catogoriesResponseDTO(name: "티켓/교환권"),
        catogoriesResponseDTO(name: "도서"),
        catogoriesResponseDTO(name: "유아도서"),
        catogoriesResponseDTO(name: "기타 중고물품"),
        catogoriesResponseDTO(name: "삽니다")
    ]
}
