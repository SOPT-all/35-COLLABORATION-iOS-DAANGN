//
//  SimilarItemsCollectionReusableView.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/27/24.
//

import UIKit

import SnapKit
import Then

final class SimilarItemsCollectionReusableView: UICollectionReusableView {
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        titleLabel.do {
            $0.text = I18N.Search.cantfindItem
            $0.textColor = .gray9
            $0.font = .sfPro(.title_sb_17)
        }
        
        subTitleLabel.do {
            $0.text = I18N.Search.showSimilarItems
            $0.textColor = .gray5
            $0.font = .sfPro(.body_md_13)
        }
    }
    
    private func setHierarchy() {
        addSubviews(titleLabel, subTitleLabel)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
}

extension SimilarItemsCollectionReusableView: ClassNameProtocol {
    
    func configure(searchKeyword: String) {
        subTitleLabel.text = "'\(searchKeyword)'" + I18N.Search.showSimilarItems
    }
}
