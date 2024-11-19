//
//  ProductDetailSection.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/20/24.
//

import Foundation

enum ProductDetailSection: Int, CaseIterable {
    case detailImage = 0
    case userInfo
    case productInfo
    case sellerProduct
    case keywordNotify
    case relatedArticle
    
    var numberOfItemsInSection: Int {
        switch self {
        case .detailImage:
            return 4
        default:
            return 1
        }
    }
}
