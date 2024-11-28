//
//  CategoryResponseDTO.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/24/24.
//

import Foundation

struct CatogoriesResponseDTO: Codable {
    let name: String

    static let sampleCategories: [CatogoriesResponseDTO] = [
        CatogoriesResponseDTO(name: "디지털기기"),
        CatogoriesResponseDTO(name: "가구/인테리어"),
        CatogoriesResponseDTO(name: "유아동"),
        CatogoriesResponseDTO(name: "여성의류"),
        CatogoriesResponseDTO(name: "여성잡화"),
        CatogoriesResponseDTO(name: "남성패션/잡화"),
        CatogoriesResponseDTO(name: "생활가전"),
        CatogoriesResponseDTO(name: "생활/주방"),
        CatogoriesResponseDTO(name: "스포츠/레저"),
        CatogoriesResponseDTO(name: "취미/게임/음반"),
        CatogoriesResponseDTO(name: "뷰티/미용"),
        CatogoriesResponseDTO(name: "식물"),
        CatogoriesResponseDTO(name: "가공식품"),
        CatogoriesResponseDTO(name: "건강기능식품"),
        CatogoriesResponseDTO(name: "반려동물용품"),
        CatogoriesResponseDTO(name: "티켓/교환권"),
        CatogoriesResponseDTO(name: "도서"),
        CatogoriesResponseDTO(name: "유아도서"),
        CatogoriesResponseDTO(name: "기타 중고물품"),
        CatogoriesResponseDTO(name: "삽니다")
    ]
}
