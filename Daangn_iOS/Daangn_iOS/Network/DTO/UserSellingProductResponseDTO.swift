//
//  UserSellingProductResponseDTO.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/28/24.
//

struct UserSellingProductResponseDTO: Codable {
    let products: [SellingProduct]
}

struct SellingProduct: Codable {
    let id: Int
    let product_image: String
    let title: String
    let price: String
}

extension UserSellingProductResponseDTO {
    
    static let sampleRelatedArticle: [SellingProduct] = [
        SellingProduct(id: 2,
                       product_image: "https://github.com/SOPT-all/35-COLLABORATION-SERVER-CARROT/blob/develop/src/main/java/com/sopt/carrot_server/global/image/img_list_home_8.png?raw=true",
                       title: "COS 코스 남성 패딩",
                       price: "10,000"),
        SellingProduct(id: 9,
                       product_image: "https://github.com/SOPT-all/35-COLLABORATION-SERVER-CARROT/blob/develop/src/main/java/com/sopt/carrot_server/global/image/img_list_search_4.png?raw=true",
                       title: "DKNY",
                       price: "40,000"),
        SellingProduct(id: 13,
                       product_image: "https://github.com/SOPT-all/35-COLLABORATION-SERVER-CARROT/blob/develop/src/main/java/com/sopt/carrot_server/global/image/img_list_search_1.png?raw=true",
                       title: "Recto 렉토 드레스 원피스 새상품",
                       price: "210,000"),
        SellingProduct(id: 20,
                       product_image: "https://github.com/SOPT-all/35-COLLABORATION-SERVER-CARROT/blob/develop/src/main/java/com/sopt/carrot_server/global/image/img_list_home_4.png?raw=true",
                       title: "노드아카이브 와이드 테이퍼드 치노 팬츠",
                       price: "6000")
    ]
}
