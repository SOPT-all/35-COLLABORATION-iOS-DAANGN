//
//  ProductImageCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/21/24.
//

import UIKit

import SnapKit
import Then

class ProductImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Component
    
    private let detailImageView = UIImageView()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI&Layout
    
    private func setStyle() {
        backgroundColor = .clear
        
        detailImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.makeCornerRound(radius: 6)
            $0.image = .imgDetails
        }
    }
    
    private func setHierarchy() {
        addSubview(detailImageView)
    }
    
    private func setLayout() {
        detailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - ClassNameProtocol

extension ProductImageCollectionViewCell: ClassNameProtocol { }
