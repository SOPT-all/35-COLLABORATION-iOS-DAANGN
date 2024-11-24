//
//  IntrinsicCollectionView.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/24/24.
//

import UIKit

class IntrinsicCollectionView: UICollectionView {
    override func layoutSubviews() {
        self.invalidateIntrinsicContentSize()
        super.layoutSubviews()
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
