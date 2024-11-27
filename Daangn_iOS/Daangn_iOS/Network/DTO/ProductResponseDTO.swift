//
//  ProductResponseDTO.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/19/24.
//

import Foundation

struct ProductResponseDTO: Codable {
    let products: [Product]
    
    static let sampleProducts: ProductResponseDTO = ProductResponseDTO(products: [
         Product(
             id: 1,
             userId: 101,
             productImage: "img_list_home_1",
             title: "콜나고 프리마베라 로드자전거 판매합니다",
             price: "850,000원",
             address: "가락동",
             view: 150
         ),
         Product(
             id: 2,
             userId: 102,
             productImage: "img_list_home_2",
             title: "자이언트 프로펠 어드밴스 2",
             price: "1,350,000원",
             address: "잠실동",
             view: 98
         ),
         Product(
             id: 3,
             userId: 103,
             productImage: "img_list_home_3",
             title: "세터 데님자켓 새상품",
             price: "140,000원",
             address: "문정2동",
             view: 75
         ),
         Product(
             id: 4,
             userId: 104,
             productImage: "img_list_home_4",
             title: "삼천리 로드 자전거",
             price: "650,000원",
             address: "송파구",
             view: 120
         ),
         Product(
             id: 5,
             userId: 105,
             productImage: "img_list_home_5",
             title: "아이폰 13 프로 판매",
             price: "1,200,000원",
             address: "석촌동",
             view: 180
         ),
         Product(
             id: 6,
             userId: 106,
             productImage: "img_list_home_6",
             title: "캠핑용 의자",
             price: "45,000원",
             address: "강남구",
             view: 55
         ),
         Product(
             id: 7,
             userId: 107,
             productImage: "img_list_home_7",
             title: "맥북 에어 M1",
             price: "800,000원",
             address: "송파구",
             view: 200
         ),
         Product(
             id: 8,
             userId: 108,
             productImage: "img_list_home_8",
             title: "전자레인지",
             price: "30,000원",
             address: "강동구",
             view: 20
         ),
         Product(
             id: 9,
             userId: 109,
             productImage: "img_list_home_9",
             title: "책상 팝니다",
             price: "70,000원",
             address: "가락동",
             view: 95
         ),
         Product(
             id: 10,
             userId: 110,
             productImage: "img_list_home_10",
             title: "헬스 용품 세트",
             price: "100,000원",
             address: "강남구",
             view: 85
         )
     ])
}

struct Product: Codable {
    let id: Int
    let userId: Int
    let productImage: String
    let title: String
    let price: String
    let address: String
    let view: Int

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case productImage = "product_image"
        case title, price, address, view
    }
}
