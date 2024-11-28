//
//  PurchaseBottomView.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/27/24.
//

import UIKit

import SnapKit
import Then

class PurchaseBottomView: UIView {
    
    // MARK: - Property
    
    private var sampleProductInfo: ProductDetailResponseDTO?
    
    // MARK: - UI Component
    
    private let horizontalDivider = UIView()
    private let likeButton = UIButton()
    private let priceLabel = UILabel()
    private let carrotPayImageView = UIImageView()
    private let proposeLabel = UILabel()
    private let chatButton = UIButton()
    private let firstVerticalDivider = UIView()
    private let secondVerticalDivider = UIView()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI&Layout
    
    private func setStyle() {
        backgroundColor = .white
        
        horizontalDivider.do {
            $0.backgroundColor = .gray4
        }
        
        likeButton.do {
            $0.setImage(.icLikeLgGray, for: .normal)
        }
        
        priceLabel.do {
            $0.font = .sfPro(.body_hv_16)
            $0.textColor = .gray11
        }
        
        carrotPayImageView.do {
            $0.image = .image488
            $0.contentMode = .scaleAspectFill
        }
        
        proposeLabel.do {
            $0.text = "가격제안 불가"
            $0.font = .sfPro(.body_md_14_028)
            $0.textColor = .gray6
            $0.setAttributedText(letterSpacing: -0.28)
        }
        
        chatButton.do {
            $0.configuration = UIButton.Configuration.plain()
            $0.configuration?.attributedTitle = AttributedString(
                UIFont.sfProAttributedString(
                    text: "채팅하기",
                    style: .title_bla_15_22,
                    color: .white,
                    lineHeight: 22
                )
            )
            $0.configuration?.contentInsets = NSDirectionalEdgeInsets(
                top: 8,
                leading: 16,
                bottom: 8,
                trailing: 16
            )
            $0.backgroundColor = .orange1
            $0.makeCornerRound(radius: 6)
        }
        
        firstVerticalDivider.do {
            $0.backgroundColor = .gray4
        }
        
        secondVerticalDivider.do {
            $0.backgroundColor = .gray4
        }
    }
    
    private func setUI() {
        addSubviews(horizontalDivider, likeButton, firstVerticalDivider, priceLabel, secondVerticalDivider, carrotPayImageView, proposeLabel, chatButton)
    }
    
    private func setLayout() {
        horizontalDivider.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
            $0.leading.equalToSuperview().inset(14)
            $0.size.equalTo(28)
        }
        
        firstVerticalDivider.snp.makeConstraints {
            $0.centerY.equalTo(likeButton)
            $0.leading.equalTo(likeButton.snp.trailing).offset(14)
            $0.height.equalTo(40)
            $0.width.equalTo(0.8)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(likeButton.snp.trailing).offset(32)
        }
        
        secondVerticalDivider.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.leading.equalTo(priceLabel.snp.trailing).offset(6)
            $0.height.equalTo(8)
            $0.width.equalTo(0.8)
        }
        
        carrotPayImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(secondVerticalDivider.snp.trailing).offset(5)
            $0.width.equalTo(50)
            $0.height.equalTo(29)
        }
        
        proposeLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(2)
            $0.leading.equalTo(priceLabel)
        }
        
        chatButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

// MARK: - configure

extension PurchaseBottomView {
    func configure(with product: ProductDetailResponseDTO) {
        priceLabel.text = "\(product.price)원"
        priceLabel.setAttributedText(lineHeight: 23.2)
    }
}
