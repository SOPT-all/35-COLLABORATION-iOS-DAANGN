//
//  TopTabbarModel.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import Foundation

struct TopTabbarModel {
    let title: String
}

extension TopTabbarModel {
    static func filterTopTabbarData() -> [TopTabbarModel] {
        return [
            TopTabbarModel(title: I18N.Common.neighborhoodRange),
            TopTabbarModel(title: I18N.Common.price),
            TopTabbarModel(title: I18N.Common.category),
            TopTabbarModel(title: I18N.Common.inOrderOfAccuracy)
        ]
    }
    
    static func searchTopTabbarData() -> [TopTabbarModel] {
        return [
            TopTabbarModel(title: I18N.Common.integration),
            TopTabbarModel(title: I18N.Common.secondHandTrading),
            TopTabbarModel(title: I18N.Common.neighborhoodLife),
            TopTabbarModel(title: I18N.Common.localBusiness),
            TopTabbarModel(title: I18N.Common.neighborhoodPromotion)
        ]
    }
}
