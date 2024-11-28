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
    
    private let profileImageView = UIImageView()
    private let badgeImageView = UIImageView()
    private let nicknameLabel = UILabel()
    private let verticalDivider = UIView()
    private let timeLabel = UILabel()
    private let addressLabel = UILabel()
    private let degreeLabel = UILabel()
    private let degreeImageView = UIImageView()
    private let degreeBackgroundView = UIView()
    private let degreeView = UIView()
    private let mannerDegreeLabel = UILabel()
    private let horizontalDivider = UIView()
    
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
        
        profileImageView.do {
            $0.contentMode = .scaleAspectFill
        }
        
        badgeImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.image = .imgCarrierSm
        }
        
        nicknameLabel.do {
            $0.font = .sfPro(.body_md_16)
            $0.textColor = .gray9
        }
        
        verticalDivider.do {
            $0.backgroundColor = .gray4
        }
        
        timeLabel.do {
            $0.text = "5시간 전 접속"
            $0.font = .sfPro(.caption_md_11)
            $0.textColor = .gray5
        }
        
        addressLabel.do {
            $0.font = .sfPro(.body_md_12)
            $0.textColor = .gray8
        }
        
        degreeLabel.do {
            $0.text = "46.5℃"
            $0.font = .sfPro(.body_bla_16)
            $0.textColor = .orange2
        }
        
        degreeBackgroundView.do {
            $0.backgroundColor = .gray4
            $0.makeCornerRound(radius: 3 / 2)
        }
        
        degreeView.do {
            $0.backgroundColor = .orange2
            $0.makeCornerRound(radius: 3 / 2)
        }
        
        degreeImageView.do {
            //$0.image = .image482
            $0.contentMode = .scaleAspectFill
        }
        
        mannerDegreeLabel.do {
            $0.text = "매너온도"
            $0.font = .sfPro(.caption_r_12_08)
            $0.setAttributedText(letterSpacing: -0.8, lineHeight: 10)
            $0.textColor = .gray7
        }
        
        horizontalDivider.do {
            $0.backgroundColor = .gray3
        }
        
    }
    
    private func setHierarchy() {
        degreeBackgroundView.addSubview(degreeView)
        addSubviews(
            profileImageView, badgeImageView, nicknameLabel, verticalDivider, timeLabel, addressLabel,
            degreeLabel, degreeBackgroundView, degreeImageView, mannerDegreeLabel, horizontalDivider)
    }
    
    private func setLayout() {
        
        profileImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
            $0.size.equalTo(50)
        }
        
        badgeImageView.snp.makeConstraints {
            $0.leading.top.equalTo(profileImageView).offset(32)
            $0.size.equalTo(23)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(6)
            $0.top.equalTo(profileImageView.snp.top).offset(4)
        }
        
        verticalDivider.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(nicknameLabel)
            $0.width.equalTo(1)
            $0.height.equalTo(10)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(verticalDivider.snp.trailing).offset(10)
            $0.centerY.equalTo(nicknameLabel)
        }
        
        addressLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(7)
        }
        
        degreeImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(15)
            $0.size.equalTo(27)
        }
        
        degreeLabel.snp.makeConstraints {
            $0.top.equalTo(degreeImageView)
            $0.trailing.equalTo(degreeImageView.snp.leading).offset(-4)
        }
        
        degreeBackgroundView.snp.makeConstraints {
            $0.top.equalTo(degreeLabel.snp.bottom).offset(5)
            $0.trailing.equalTo(degreeLabel)
            $0.width.equalTo(50)
            $0.height.equalTo(3)
        }
        
        degreeView.snp.makeConstraints {
            $0.top.equalTo(degreeLabel.snp.bottom).offset(5)
            $0.leading.equalTo(degreeBackgroundView.snp.leading)
            $0.width.equalTo(50*0.535)
            $0.height.equalTo(3)
        }
        
        mannerDegreeLabel.snp.makeConstraints {
            $0.trailing.equalTo(degreeImageView)
            $0.top.equalTo(degreeImageView.snp.bottom).offset(11)
        }
        
        horizontalDivider.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - ClassNameProtocol

extension SellerInfoCollectionViewCell: ClassNameProtocol { }

// MARK: - configure

extension SellerInfoCollectionViewCell {
    func configure(with seller: SellerInfo) {
        profileImageView.image = UIImage(named: seller.profileImage)
        nicknameLabel.text = seller.nickname
        addressLabel.text = seller.address
    }
}
