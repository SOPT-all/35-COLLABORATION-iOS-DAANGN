//
//  ProductDetailSection.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/20/24.
//

import Foundation

enum ProductDetailSection: Int, CaseIterable {
    case productImage = 0
    case sellerInfo
    case productDetailInfo
    case sellerProduct
    case keywordNotify
    case relatedArticle
    
    var numberOfItemsInSection: Int {
        switch self {
        case .productImage, .sellerProduct, .relatedArticle:
            return 4
        default:
            return 1
        }
    }
}
