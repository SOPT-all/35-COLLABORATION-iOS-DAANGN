//
//  SearchResultDelegate.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/28/24.
//

import Foundation

protocol SearchResultDelegate: NSObject {
    func bindSearchResult(
        keyword: String,
        products: [SearchProduct],
        similarProducts: [SearchProduct]
    )
}
