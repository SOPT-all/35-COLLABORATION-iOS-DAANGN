//
//  ProductRelatedModel.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/19/24.
//

import UIKit

struct RelatedProduct {
    let id: Int
    let detailImage: String
    let title: String
    let price: String
}

extension RelatedProduct {
    
    static let sampleSellerProducts: [RelatedProduct] = [
        RelatedProduct(id: 1, detailImage: "img_details_sales_1", title: "앤유 하프집업 맨투맨", price: "25,000"),
        RelatedProduct(id: 2, detailImage: "img_details_sales_2", title: "드레스반티아 팬츠 (새상품 미개봉)", price: "25,000"),
        RelatedProduct(id: 3, detailImage: "img_details_sales_3", title: "몽벨 모노 파우치 크로스백 가방", price: "25,000"),
        RelatedProduct(id: 4, detailImage: "img_details_sales_4", title: "독도로션 400 ml (새상품)", price: "12,000")
    ]
    
    static let sampleRelatedArticle: [RelatedProduct] = [
        RelatedProduct(id: 5, detailImage: "img_details_reco_1", title: "썸미니 라쿤 네이비", price: "80,000"),
        RelatedProduct(id: 6, detailImage: "img_details_reco_2", title: "Cerric Pleats Layered Pants set", price: "128,000"),
        RelatedProduct(id: 7, detailImage: "img_details_reco_3", title: "(실착 1회) 니티드 깡 스타일 니트집업", price: "55,000"),
        RelatedProduct(id: 8, detailImage: "img_details_reco_4", title: "LMC 레드 라벨 브라운 빅 맨투맨", price: "36,000")
    ]
}
