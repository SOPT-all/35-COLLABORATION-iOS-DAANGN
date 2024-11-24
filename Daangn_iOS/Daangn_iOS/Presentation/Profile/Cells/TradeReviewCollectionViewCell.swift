//
//  TradeReviewCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class TradeReviewCollectionViewCell: UICollectionViewCell {
    
    private let userProfileImageView = UIImageView()
    private let userNicknameLabel = UILabel()
    private let userInfoStackView = UIStackView()
    private let userTypeLabel = UILabel()
    private let addressLabel = UILabel()
    private let writingTimeLabel = UILabel()
    private let reviewLabel = UILabel()
    private let divider = UIView()
    
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
        userProfileImageView.do {
            $0.image = .imgUserXs
            $0.contentMode = .scaleAspectFill
        }
        
        userNicknameLabel.do {
            $0.textColor = .gray9
            $0.font = .sfPro(.body_hv_14)
        }
        
        userInfoStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }
        
        userTypeLabel.do {
            $0.textColor = .gray7
            $0.font = .sfPro(.caption_r_12_05)
        }
        
        addressLabel.do {
            $0.textColor = .gray7
            $0.font = .sfPro(.caption_r_12_05)
        }
        
        writingTimeLabel.do {
            $0.textColor = .gray7
            $0.font = .sfPro(.caption_r_12_05)
        }
        
        reviewLabel.do {
            $0.textColor = .gray9
            $0.font = .sfPro(.title_bla_15_22)
        }
        
        divider.do {
            $0.backgroundColor = .gray3
        }
    }
    
    private func setHierarchy() {
        contentView.addSubviews(userProfileImageView, userNicknameLabel, userInfoStackView, reviewLabel, divider)
        userInfoStackView.addArrangeSubViews(userTypeLabel, createSeparatorLabel(), addressLabel, createSeparatorLabel(), writingTimeLabel)
    }
    
    private func setLayout() {
        userProfileImageView.snp.makeConstraints {
            $0.size.equalTo(36)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        userNicknameLabel.snp.makeConstraints {
            $0.top.equalTo(userProfileImageView)
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(11)
        }
        
        userInfoStackView.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.top.equalTo(userNicknameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(userNicknameLabel)
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(userInfoStackView.snp.bottom).offset(9)
            $0.leading.equalTo(userNicknameLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(reviewLabel.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension TradeReviewCollectionViewCell: ClassNameProtocol {
    
    private func createSeparatorLabel() -> UILabel {
        return UILabel().then {
            $0.text = "·"
            $0.textColor = .gray7
            $0.snp.makeConstraints { $0.width.equalTo(4) }
        }
    }
    
    func configure(with data: TradeReviewModel) {
        if let profileImage = data.profileImage {
            userProfileImageView.image = UIImage(named: profileImage)
        }
        userNicknameLabel.text = data.nickname
        userTypeLabel.text = data.userType
        addressLabel.text = data.address
        writingTimeLabel.text = data.writingTime
        reviewLabel.text = data.content
        
        userTypeLabel.setAttributedText(letterSpacing: -0.5, lineHeight: 10)
        addressLabel.setAttributedText(letterSpacing: -0.5, lineHeight: 10)
        writingTimeLabel.setAttributedText(letterSpacing: -0.5, lineHeight: 10)
        reviewLabel.setAttributedText(lineHeight: 22)
    }
}
