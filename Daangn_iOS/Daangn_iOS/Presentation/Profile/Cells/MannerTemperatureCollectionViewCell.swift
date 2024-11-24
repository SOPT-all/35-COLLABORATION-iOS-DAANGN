//
//  MannerTemperatureCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class MannerTemperatureCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let mannerHelpButton = UIButton()
    private let firstTemperatureLabel = UILabel()
    private let arrowDownImageView = UIImageView()
    private let userTemperatureLabel = UILabel()
    private let smileImageView = UIImageView()
    private let backgroundBar = UIView()
    private let userTemperatureBar = UIView()
    private let heartImageView = UIImageView()
    private let reTransactionDesireRateLabel = UILabel()
    private let satisfactionRateLabel = UILabel()
    private let chatImageView = UIImageView()
    private let responseRateLabel = UILabel()
    private let responseTimeLabel = UILabel()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
        setTemperature()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setStyle() {
        let underlinedText: String = "매너"
        
        mannerHelpButton.do {
            var config = UIButton.Configuration.plain()
            config.attributedTitle = AttributedString(
                UIFont.sfProAttributedString(
                    text: "매너...",
                    style: .caption_md_14_028,
                    color: .gray9,
                    letterSpacing: -0.28,
                    underlineRange: NSRange(location: 0, length: underlinedText.count)
                )
            )
            config.image = .icHelp
            config.imagePlacement = .trailing
            config.imagePadding = 2
            config.contentInsets = .zero
            $0.configuration = config
        }
        
        firstTemperatureLabel.do {
            $0.text = "첫 온도 36.5℃"
            $0.textColor = .gray6
            $0.font = .sfPro(.body_md_12)
        }
        
        arrowDownImageView.do {
            $0.image = .icTriangle
            $0.contentMode = .scaleAspectFit
        }
        
        userTemperatureLabel.do {
            $0.text = "46.5℃"
            $0.textColor = .orange2
            $0.font = .sfPro(.body_bla_16)
        }
        
        smileImageView.do {
            $0.image = .imgSmile
            $0.contentMode = .scaleAspectFit
        }
        
        backgroundBar.do {
            $0.backgroundColor = .gray4
            $0.makeCornerRound(radius: 10 / 2)
        }
        
        userTemperatureBar.do {
            $0.backgroundColor = .orange2
            $0.makeCornerRound(radius: 10 / 2)
        }
        
        heartImageView.do {
            $0.image = .icLikeSmBlack
            $0.contentMode = .scaleAspectFit
        }
        
        reTransactionDesireRateLabel.do {
            $0.text = "재거래 희망률  100%"
            $0.textColor = .gray9
            $0.font = .sfPro(.body_bla_14)
        }
        
        satisfactionRateLabel.do {
            $0.text = "124명 중 124명이 만족"
            $0.textColor = .gray6
            $0.font = .sfPro(.body_b_12)
        }
        
        chatImageView.do {
            $0.image = .icChatSolo
            $0.contentMode = .scaleAspectFit
        }
        
        responseRateLabel.do {
            $0.text = "응답률  100%"
            $0.textColor = .gray9
            $0.font = .sfPro(.body_bla_14)
        }
        
        responseTimeLabel.do {
            $0.text = "보통 10분 이내 도착"
            $0.textColor = .gray6
            $0.font = .sfPro(.body_b_12)
        }
    }
    
    private func setHierarchy() {
        contentView.addSubviews(mannerHelpButton, firstTemperatureLabel, arrowDownImageView, userTemperatureLabel, smileImageView, backgroundBar, userTemperatureBar, heartImageView, reTransactionDesireRateLabel, satisfactionRateLabel, chatImageView, responseRateLabel, responseTimeLabel)
    }
    
    private func setLayout() {
        mannerHelpButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalToSuperview().inset(16)
        }
        
        userTemperatureLabel.snp.makeConstraints {
            $0.trailing.equalTo(smileImageView.snp.leading).offset(-4)
            $0.centerY.equalTo(smileImageView)
        }
        
        smileImageView.snp.makeConstraints {
            $0.size.equalTo(27)
            $0.top.equalTo(mannerHelpButton.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        backgroundBar.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.top.equalTo(smileImageView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        userTemperatureBar.snp.makeConstraints {
            $0.width.equalTo((46.5 / 100) * 343)
            $0.height.equalTo(10)
            $0.leading.equalTo(backgroundBar)
            $0.centerY.equalTo(backgroundBar)
        }
        
        heartImageView.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.top.equalTo(backgroundBar.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(16)
        }
        
        reTransactionDesireRateLabel.snp.makeConstraints {
            $0.top.equalTo(heartImageView)
            $0.leading.equalTo(heartImageView.snp.trailing).offset(4)
        }
        
        satisfactionRateLabel.snp.makeConstraints {
            $0.top.equalTo(reTransactionDesireRateLabel.snp.bottom).offset(4)
            $0.leading.equalTo(reTransactionDesireRateLabel)
            $0.bottom.equalToSuperview().inset(34)
        }
        
        chatImageView.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.top.equalTo(heartImageView)
            $0.leading.equalTo(contentView.snp.centerX).offset(8.5)
        }
        
        responseRateLabel.snp.makeConstraints {
            $0.top.equalTo(chatImageView)
            $0.leading.equalTo(chatImageView.snp.trailing).offset(4)
        }
        
        responseTimeLabel.snp.makeConstraints {
            $0.top.equalTo(responseRateLabel.snp.bottom).offset(4)
            $0.leading.equalTo(responseRateLabel)
            $0.bottom.equalToSuperview().inset(34)
        }
    }
    
    private func setTemperature() {
        let positionOf36_5degree = (36.5 / 100) * 343
        
        firstTemperatureLabel.snp.makeConstraints {
            $0.bottom.equalTo(arrowDownImageView.snp.top)
            $0.centerX.equalTo(arrowDownImageView)
        }
        
        arrowDownImageView.snp.makeConstraints {
            $0.centerX.equalTo(backgroundBar.snp.leading).offset(positionOf36_5degree)
            $0.bottom.equalTo(userTemperatureBar.snp.top).offset(-6)
        }
    }
}

extension MannerTemperatureCollectionViewCell: ClassNameProtocol {}
