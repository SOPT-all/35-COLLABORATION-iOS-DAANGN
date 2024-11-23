//
//  VerificationInfoCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class VerificationInfoCollectionViewCell: UICollectionViewCell {
    
    private let addressVerificationLabel = UILabel()
    private let recentActivityLabel = UILabel()
    
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
        backgroundColor = .gray2
        
        addressVerificationLabel.do {
            $0.text = "•  송파구 삼전동 23회  인증, 서울특별시 강동구 1회 인증 (최근 30일)"
            $0.textColor = .gray8
            $0.font = .sfPro(.body_md_13_052)
            $0.setAttributedText(letterSpacing: -0.52)
        }
        
        recentActivityLabel.do {
            $0.text = "•  최근 3일 이내 활동 (2019년  7월  13일 가입)"
            $0.textColor = .gray8
            $0.font = .sfPro(.body_md_13_052)
            $0.setAttributedText(letterSpacing: -0.52)
        }
    }
    
    private func setHierarchy() {
        contentView.addSubviews(addressVerificationLabel, recentActivityLabel)
    }
    
    private func setLayout() {
        addressVerificationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        recentActivityLabel.snp.makeConstraints {
            $0.top.equalTo(addressVerificationLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(25)
        }
    }
}

extension VerificationInfoCollectionViewCell: ClassNameProtocol {}
