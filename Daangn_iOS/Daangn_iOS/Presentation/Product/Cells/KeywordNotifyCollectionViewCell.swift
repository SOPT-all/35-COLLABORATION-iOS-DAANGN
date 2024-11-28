//
//  KeywordNotifyCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/21/24.
//

import UIKit

import SnapKit
import Then

class KeywordNotifyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Component
    
    private let firstHorizontalDivider = UIView()
    private let notifyLabel = UILabel()
    private let keywordNotifyButton = UIButton()
    private let secondHorizontalDivider = UIView()
    
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
        
        firstHorizontalDivider.do {
            $0.backgroundColor = .gray3
        }
        
        notifyLabel.do {
            $0.numberOfLines = 2
            $0.font = .sfPro(.body_md_13)
            $0.textColor = .gray9
        }
        
        keywordNotifyButton.do {
            $0.configuration = UIButton.Configuration.plain()
            $0.configuration?.image = UIImage(resource: .icNotificationSmBlack)
            $0.configuration?.imagePadding = 8
            $0.configuration?.imagePlacement = .leading
            $0.configuration?.attributedTitle = AttributedString(
                UIFont.sfProAttributedString(
                    text: "키워드 알림 받기",
                    style: .body_md_13,
                    color: .gray9
                )
            )
            $0.configuration?.contentInsets = NSDirectionalEdgeInsets(
                top: 10,
                leading: 16,
                bottom: 10,
                trailing: 16
            )
            $0.backgroundColor = .gray2
            $0.makeCornerRound(radius: 6)
        }
        
        secondHorizontalDivider.do {
            $0.backgroundColor = .gray3
        }
    }
    
    private func setHierarchy() {
        addSubviews(firstHorizontalDivider, notifyLabel, keywordNotifyButton, secondHorizontalDivider)
    }
    
    private func setLayout() {
        firstHorizontalDivider.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        notifyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        keywordNotifyButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        secondHorizontalDivider.snp.makeConstraints {
            $0.top.equalTo(keywordNotifyButton.snp.bottom).offset(23)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

// MARK: - ClassNameProtocol

extension KeywordNotifyCollectionViewCell: ClassNameProtocol { }

// MARK: - configure

extension KeywordNotifyCollectionViewCell {
    func configure(with product: ProductDetailResponseDTO) {
        notifyLabel.text = "이웃들이 \(product.title) 게시글을\n올리면 바로 알려드릴까요?"
        notifyLabel.setAttributedText(lineHeight: 22)
    }
}
