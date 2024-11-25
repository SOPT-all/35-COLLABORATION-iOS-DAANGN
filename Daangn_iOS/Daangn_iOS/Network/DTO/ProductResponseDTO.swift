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
    let distance: String
    let location: String
    let time: String
    let price: String
    let chatCount: Int
    let likeCount: Int
}
