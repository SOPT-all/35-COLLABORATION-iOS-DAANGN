//
//  ProductResponseDTO.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/19/24.
//

import Foundation

struct ProductResponseDTO: Codable {
    let products: [Product]
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
