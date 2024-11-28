//
//  OnSaleFilterCollectionReusableView.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/27/24.
//

import UIKit

import SnapKit
import Then

final class OnSaleFilterCollectionReusableView: UICollectionReusableView {
    
    private let checkButton = UIButton()
    private let onSaleOnlyLabel = UILabel()
    
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
        checkButton.do {
            $0.setImage(.icCheck, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
        
        onSaleOnlyLabel.do {
            $0.text = I18N.Search.viewOnlyOnSale
            $0.textColor = .gray9
            $0.font = .sfPro(.body_md_13)
        }
    }
    
    private func setHierarchy() {
        addSubviews(checkButton, onSaleOnlyLabel)
    }
    
    private func setLayout() {
        checkButton.snp.makeConstraints {
            $0.size.equalTo(28)
            $0.leading.equalToSuperview().inset(11)
            $0.centerY.equalToSuperview()
        }
        
        onSaleOnlyLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(5)
            $0.centerY.equalToSuperview()
        }
    }
}

extension OnSaleFilterCollectionReusableView: ClassNameProtocol {}
