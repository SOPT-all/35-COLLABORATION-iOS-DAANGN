//
//  ProductCardViewCell.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/17/24.
//

import UIKit
import SwiftUI

import SnapKit
import Then

class ProductCardViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    private let thumbnailImage = UIImageView()
    private let titleLabel = UILabel()
    
    private let infoHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .center
        return stackView
    }()
    
    private let interactionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .leading
        return stackView
    }()
    
    private let distanceImage = UIImageView()
    private let distanceLabel = UILabel()
    private let locationLabel = UILabel()
    private let timeLabel = UILabel()
    private let priceLabel = UILabel()
    
    private let chatImage = UIImageView()
    private let chatCountLabel = UILabel()
    private let likeImage = UIImageView()
    private let likeCountLabel = UILabel()
    private let menuIconImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI(with product: Product) {
        thumbnailImage.image = UIImage(named: product.thumbnailImageName)
        titleLabel.text = product.title
        priceLabel.text = product.price
        
        setupDynamicStackViews(
            distance: product.distance,
            location: product.location,
            time: product.time,
            chatCount: product.chatCount,
            likeCount: product.likeCount
        )
    }
    
    
    private func setupDynamicStackViews(distance: String?, location: String?, time: String?, chatCount: Int?, likeCount: Int?) {
        // 1. Info 스택 초기화
        infoHStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        interactionStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if let distance = distance {
            let distanceImage = UIImageView().then {
                $0.image = .icLocation
                $0.contentMode = .scaleAspectFit
                $0.snp.makeConstraints { $0.width.height.equalTo(12) }
            }
            let distanceLabel = createLabel(with: distance)
            infoHStackView.addArrangedSubview(distanceImage)
            infoHStackView.addArrangedSubview(distanceLabel)
        }
        
        if let location = location {
            addSeparatorIfNeeded(to: infoHStackView)
            let locationLabel = createLabel(with: location)
            infoHStackView.addArrangedSubview(locationLabel)
        }
        
        if let time = time {
            addSeparatorIfNeeded(to: infoHStackView)
            let timeLabel = createLabel(with: time)
            infoHStackView.addArrangedSubview(timeLabel)
        }
        
        if let chatCount = chatCount, chatCount > 0 {
            let chatImage = UIImageView().then {
                $0.image = .icChatSm
                $0.contentMode = .scaleAspectFit
                $0.snp.makeConstraints { $0.width.height.equalTo(18) }
            }
            let chatLabel = createLabel(with: "\(chatCount)")
            interactionStackView.addArrangedSubview(chatImage)
            interactionStackView.addArrangedSubview(chatLabel)
        }
        
        if let likeCount = likeCount, likeCount > 0 {
            let likeImage = UIImageView().then {
                $0.image = .icLikeSmGray
                $0.contentMode = .scaleAspectFit
                $0.snp.makeConstraints { $0.width.height.equalTo(18) }
            }
            let likeLabel = createLabel(with: "\(likeCount)")
            interactionStackView.addArrangedSubview(likeImage)
            interactionStackView.addArrangedSubview(likeLabel)
        }
    }

    private func createSeparator() -> UIImageView {
        return UIImageView().then {
            $0.image = UIImage(systemName: "circle.fill")
            $0.tintColor = .gray
            $0.contentMode = .scaleAspectFit
            $0.snp.makeConstraints { $0.width.height.equalTo(4) } // 적절한 크기로 조정
        }
    }

    private func addSeparatorIfNeeded(to stackView: UIStackView) {
        if !stackView.arrangedSubviews.isEmpty {
            let separator = createSeparator()
            stackView.addArrangedSubview(separator)
        }
    }

    private func createLabel(with text: String) -> UILabel {
        return UILabel().then {
            $0.text = text
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .gray
        }
    }
    
    // MARK: - UI Setup
    private func setStyle() {
        thumbnailImage.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
        }
        
        titleLabel.do {
            $0.font = .boldSystemFont(ofSize: 16)
            $0.textColor = .black
            $0.numberOfLines = 2
        }
        
        locationLabel.do {
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .gray
        }
        
        timeLabel.do {
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .gray
        }
        
        priceLabel.do {
            $0.font = .boldSystemFont(ofSize: 14)
            $0.textColor = .black
        }
        
        chatImage.do {
            $0.contentMode = .scaleAspectFit
        }
        
        chatCountLabel.do {
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .gray
        }
        
        likeImage.do {
            $0.contentMode = .scaleAspectFit
        }
        
        likeCountLabel.do {
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .gray
        }
        
        menuIconImage.do {
            $0.image = .icMenuKebabGray
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setUI() {
        [thumbnailImage, titleLabel, infoHStackView, interactionStackView, priceLabel, menuIconImage].forEach {
            contentView.addSubview($0) // 각 UI 요소를 contentView에 추가
        }
    }
    
    private func setLayout() {
        thumbnailImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(108)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImage.snp.top)
            $0.leading.equalTo(thumbnailImage.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        infoHStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(infoHStackView.snp.bottom).offset(2)
            $0.leading.equalTo(infoHStackView.snp.leading)
        }
        
        interactionStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(57)
            $0.trailing.equalToSuperview().offset(-17)
        }
        
        menuIconImage.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(24)
        }
    }
}

// MARK: - Product DTO
struct Product {
    let thumbnailImageName: String
    let title: String
    let distance: String
    let location: String
    let time: String
    let price: String
    let chatCount: Int
    let likeCount: Int
}
