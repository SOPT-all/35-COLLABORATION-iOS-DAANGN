//
//  ProductDetailSection.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/20/24.
//

import Foundation

enum ProductDetailSection: String, CaseIterable {
    case productImage
    case sellerInfo
    case productDetailInfo
    case sellerProduct = "헿헿님의 판매 물품"
    case keywordNotify
    case relatedArticle = "이 글과 함께 봤어요"
    
    var numberOfItemsInSection: Int {
        switch self {
        case .productImage, .sellerProduct, .relatedArticle:
            return 4
        default:
            return 1
        }
    }
}
