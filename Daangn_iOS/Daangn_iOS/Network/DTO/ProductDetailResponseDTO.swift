//
//  ProductDetailResponseDTO.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/26/24.
//

struct ProductDetailResponseDTO: Codable  {
    let product_id: Int
    let product_image: String
    let title: String
    let category: String
    let content: String
    let price: String
    let view: Int
}

extension ProductDetailResponseDTO {
    
    static let productDetailResponseDTO: ProductDetailResponseDTO = ProductDetailResponseDTO(
        product_id: 1,
        product_image: "img_details",
        title: "렉토 맨투맨",
        category: "여성의류",
        content: "정가 118000\n\n5회미만 착용 세탁 후 보관중\n짱짱하고 핏도 예뻐요\n팔 안쪽에 연하게 얼룩 감안해서 가격 낮춰팝니다\n\n*배송비4000 반값1700",
        price: "75,000",
        view: 201
    )
}
