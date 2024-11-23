//
//  ProductRelatedHeader.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/21/24.
//

import UIKit

import SnapKit
import Then

class ProductRelatedHeaderReusableView: UICollectionReusableView {
    
    // MARK: - UI Component
    
    private let titleLabel = UILabel()
    
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
        
        titleLabel.do {
            $0.font = .sfPro(.title_bla_15_22)
            $0.textColor = .gray9
        }
    }
    
    private func setHierarchy() {
        addSubview(titleLabel)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
    }
}

// MARK: - Configure

extension ProductRelatedHeaderReusableView {
    
    func configure(title: String) {
        titleLabel.text = title
        titleLabel.setAttributedText(lineHeight: 22)
    }
}

// MARK: - ClassNameProtocol

extension ProductRelatedHeaderReusableView: ClassNameProtocol { }
