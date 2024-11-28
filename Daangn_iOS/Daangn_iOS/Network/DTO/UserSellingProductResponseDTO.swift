//
//  UserSellingProductResponseDTO.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/28/24.
//

struct UserSellingProductResponseDTO: Codable {
    let sellingProductList: [SellingProduct]
}

struct SellingProduct: Codable {
    let id: Int
    let product_image: String
    let title: String
    let price: String
}
