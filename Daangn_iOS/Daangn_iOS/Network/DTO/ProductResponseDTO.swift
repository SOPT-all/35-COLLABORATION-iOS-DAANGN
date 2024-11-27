//
//  ProductResponseDTO.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/19/24.
//

import Foundation

struct ProductResponseDTO: Codable {
    let productList: [Product]
}

struct Product: Codable {
    let thumbnailImageName: String
    let title: String
    let distance: String?
    let location: String
    let time: String
    let price: String
    let chatCount: Int?
    let likeCount: Int
}

extension ProductResponseDTO {
  
    static let sampleProducts: [Product] = [
        Product(
            thumbnailImageName: "img_list_home_1",
            title: "콜나고 프리마베라 로드자전거 판매합니다",
            distance: "1.5km",
            location: "가락동",
            time: "10분 전",
            price: "850,000원",
            chatCount: 1,
            likeCount: 10
        ),
        Product(
            thumbnailImageName: "img_list_home_2",
            title: "자이언트 프로펠 어드밴스 2",
            distance: "3.1km",
            location: "잠실동",
            time: "3시간 전",
            price: "1,350,000원",
            chatCount: nil,
            likeCount: 15
        ),
        Product(
            thumbnailImageName: "img_list_home_3",
            title: "세터 데님자켓 새상품",
            distance: nil,
            location: "문정2동",
            time: "8분 전",
            price: "140,000원",
            chatCount: nil,
            likeCount: 8
        ),
        Product(
            thumbnailImageName: "img_list_home_4",
            title: "삼천리 로드 자전거",
            distance: "2.3km",
            location: "송파구",
            time: "5시간 전",
            price: "650,000원",
            chatCount: 3,
            likeCount: 7
        ),
        Product(
            thumbnailImageName: "img_list_home_5",
            title: "아이폰 13 프로 판매",
            distance: "0.9km",
            location: "석촌동",
            time: "1시간 전",
            price: "1,200,000원",
            chatCount: 4,
            likeCount: 20
        ),
        Product(
            thumbnailImageName: "img_list_home_6",
            title: "캠핑용 의자",
            distance: "4.2km",
            location: "강남구",
            time: "30분 전",
            price: "45,000원",
            chatCount: 1,
            likeCount: 5
        ),
        Product(
            thumbnailImageName: "img_list_home_7",
            title: "맥북 에어 M1",
            distance: "2.8km",
            location: "송파구",
            time: "3일 전",
            price: "800,000원",
            chatCount: 2,
            likeCount: 12
        ),
        Product(
            thumbnailImageName: "img_list_home_8",
            title: "전자레인지",
            distance: "3.5km",
            location: "강동구",
            time: "6시간 전",
            price: "30,000원",
            chatCount: 0,
            likeCount: 2
        ),
        Product(
            thumbnailImageName: "img_list_home_9",
            title: "책상 팝니다",
            distance: "2.0km",
            location: "가락동",
            time: "2일 전",
            price: "70,000원",
            chatCount: 1,
            likeCount: 8
        ),
        Product(
            thumbnailImageName: "img_list_home_10",
            title: "헬스 용품 세트",
            distance: "5.0km",
            location: "강남구",
            time: "5시간 전",
            price: "100,000원",
            chatCount: 2,
            likeCount: 10
        )        
    ]
}
