//
//  SearchResponseDTO.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/28/24.
//

import Foundation

struct SearchResponseDTO: Codable {
    let products: [SearchProduct]
    let similar_products: [SearchProduct]
}

struct SearchProduct: Codable {
    let id: Int
    let user_id: Int
    let product_image: String
    let title: String
    let address: String
    let price: String
}
