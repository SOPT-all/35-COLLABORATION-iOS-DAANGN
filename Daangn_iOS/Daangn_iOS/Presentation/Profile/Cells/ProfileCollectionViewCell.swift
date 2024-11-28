//
//  ProfileCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class ProfileCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let profileImageView = UIImageView()
    private let miniBadgeImageView = UIImageView()
    private let nicknameLabel = UILabel()
    private let userCodeLabel = UILabel()
    private let lastAccessTimeLabel = UILabel()
    private let buttonStackView = UIStackView()
    private let mannersPraiseButton = UIButton()
    private let followButton = UIButton()
    
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
    
    // MARK: - Methods
    
    private func setStyle() {
        profileImageView.do {
            $0.image = .imgUserLg
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.makeCornerRound(radius: 72 / 2)
        }
        
        miniBadgeImageView.do {
            $0.image = .imgCarrierMd
            $0.contentMode = .scaleAspectFit
        }
        
        nicknameLabel.do {
            $0.font = .sfPro(.body_md_16)
            $0.textColor = .gray9
        }
        
        userCodeLabel.do {
            $0.text = "#5434272"
            $0.textColor = .gray7
            $0.font = .sfPro(.body_md_14_028)
            $0.setAttributedText(letterSpacing: -0.28)
        }
        
        lastAccessTimeLabel.do {
            $0.text = "5시간 전 접속"
            $0.textColor = .gray5
            $0.font = .sfPro(.caption_md_11)
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 7
            $0.distribution = .fillEqually
        }
        
        mannersPraiseButton.do {
            $0.setAttributedTitle(
                UIFont.sfProAttributedString(
                    text: I18N.Profile.mannerPraise,
                    style: .body_md_13_026,
                    color: .gray9,
                    letterSpacing: -0.26
                ),
                for: .normal
            )
            $0.backgroundColor = .gray2
            $0.makeCornerRound(radius: 4)
        }
        
        followButton.do {
            $0.setAttributedTitle(
                UIFont.sfProAttributedString(
                    text: I18N.Profile.follow,
                    style: .body_md_13_026,
                    color: .orange1,
                    letterSpacing: -0.26
                ),
                for: .normal
            )
            $0.backgroundColor = .orange3
            $0.makeCornerRound(radius: 4)
        }
    }
    
    private func setHierarchy() {
        contentView.addSubviews(profileImageView, miniBadgeImageView, nicknameLabel, userCodeLabel, lastAccessTimeLabel, buttonStackView)
        buttonStackView.addArrangeSubViews(mannersPraiseButton, followButton)
    }
    
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(72)
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        miniBadgeImageView.snp.makeConstraints {
            $0.size.equalTo(26)
            $0.trailing.equalTo(profileImageView.snp.trailing).offset(2)
            $0.bottom.equalTo(profileImageView.snp.bottom).offset(2)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView).offset(16)
            $0.leading.equalTo(miniBadgeImageView.snp.trailing).offset(12)
        }
        
        userCodeLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(2)
            $0.centerY.equalTo(nicknameLabel)
        }
        
        lastAccessTimeLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(nicknameLabel)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.top.equalTo(miniBadgeImageView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}

extension ProfileCollectionViewCell: ClassNameProtocol {
    
    func configure(profileImage: String?, nickname: String) {
        if let profileImage = profileImage {
            self.profileImageView.kf.setImage(with: URL(string: profileImage))
        }
        self.nicknameLabel.text = nickname
    }
}
