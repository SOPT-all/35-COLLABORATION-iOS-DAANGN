//
//  BadgeCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class BadgeCollectionViewCell: UICollectionViewCell {
    
    private let badgeImageView = UIImageView()
    private let badgeNameLabel = UILabel()
    private let badgeDescriptionLabel = UILabel()
    
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
        badgeImageView.do {
            $0.image = .imgCarrierLg
            $0.contentMode = .scaleAspectFit
        }
        
        badgeNameLabel.do {
            $0.text = "비우는 재미"
            $0.textColor = .gray9
            $0.font = .sfPro(.body_md_12)
        }
        
        badgeDescriptionLabel.do {
            $0.text = "판매글이 100개를 돌파했어요! 내가 더는 사용하지 않는 물건이 누군가에겐 꼭 필요한 물건이에요. 오늘 비우는 기쁨을 느껴보세요."
            $0.textColor = .gray9
            $0.font = .sfPro(.body_md_12_024)
            $0.setAttributedText(letterSpacing: -0.24, lineHeight: 19)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }
    }
    
    private func setHierarchy() {
        contentView.addSubviews(badgeImageView, badgeNameLabel, badgeDescriptionLabel)
    }
    
    private func setLayout() {
        badgeImageView.snp.makeConstraints {
            $0.size.equalTo(53)
            $0.top.equalTo(badgeNameLabel.snp.bottom).offset(-2)
            $0.leading.equalToSuperview().inset(28)
        }
        
        badgeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalTo(badgeImageView.snp.trailing).offset(24)
            $0.trailing.equalToSuperview().inset(45)
        }
        
        badgeDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(badgeNameLabel.snp.bottom).offset(14-2.5)
            $0.horizontalEdges.equalTo(badgeNameLabel)
            $0.bottom.equalToSuperview().inset(26-2.5)
        }
    }
}

extension BadgeCollectionViewCell: ClassNameProtocol {}
