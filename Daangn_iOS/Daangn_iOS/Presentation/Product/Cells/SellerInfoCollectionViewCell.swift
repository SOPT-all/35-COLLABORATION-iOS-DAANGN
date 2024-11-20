//
//  SellerInfoCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/21/24.
//

import UIKit

import SnapKit
import Then

class SellerInfoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Component
    
    private let sampleView = UIView()
    
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
        
        sampleView.do {
            $0.backgroundColor = .blue
        }
    }
    
    private func setHierarchy() {
        addSubview(sampleView)
    }
    
    private func setLayout() {
        sampleView.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
    }
}
