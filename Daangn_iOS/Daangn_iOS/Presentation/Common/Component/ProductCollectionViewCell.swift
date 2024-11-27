//
//  ProductCardViewCell.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/17/24.
//

import UIKit

import SnapKit
import Then

final class ProductCollectionViewCell: UICollectionViewCell, ClassNameProtocol {
    
    // MARK: - UI Components
    
    private let thumnailImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let chatAndLikeHStackView = UIStackView()
    private let menuIconImageView = UIImageView()
    private let separatorView = UIView()
    
    private let infoHStackView = UIStackView()
    
    private lazy var distanceImageView = UIImageView().then {
        $0.image = .icLocation
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var distanceLabel = UILabel().then {
        $0.font = .sfPro(.body_md_13_026)
        $0.textColor = .gray8
    }
    
    private lazy var locationLabel = UILabel().then {
        $0.font = .sfPro(.body_md_13_026)
        $0.textColor = .gray8
    }
    
    private lazy var timeLabel = UILabel().then {
        $0.font = .sfPro(.body_md_13_026)
        $0.textColor = .gray8
    }
    
    private lazy var chatButton = UIButton()
        .then {
            var config = UIButton.Configuration.plain()
            config.image = .icChatSm
            config.imagePadding = 2
            config.baseForegroundColor = .gray6
            $0.configuration = config
            $0.snp.makeConstraints {
                $0.height.width.equalTo(18)
            }
        }
        .then {
            chatAndLikeHStackView.addArrangeSubViews($0)
        }
    
    private lazy var likeButton = UIButton()
        .then {
            var config = UIButton.Configuration.plain()
            config.image = .icLikeSmGray
            config.imagePadding = 2
            config.baseForegroundColor = .gray6
            $0.configuration = config
            $0.snp.makeConstraints {
                $0.height.width.equalTo(18)
            }
        }
        .then {
            chatAndLikeHStackView.addArrangeSubViews($0)
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setStyle() {
        thumnailImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
        }
        
        titleLabel.do {
            $0.font = .sfPro(.title_bla_15_22)
            $0.textColor = .black
            $0.numberOfLines = 2
            $0.lineBreakMode = .byCharWrapping
        }
        
        infoHStackView.do {
            $0.axis = .horizontal
            $0.spacing = 2
            $0.alignment = .center
        }
        
        chatAndLikeHStackView.do {
            $0.axis = .horizontal
            $0.spacing = 16
            $0.alignment = .leading
        }
        
        priceLabel.do {
            $0.font = .sfPro(.body_hv_16)
            $0.textColor = .black
        }
        
        menuIconImageView.do {
            $0.image = .icMenuKebabGray
            $0.contentMode = .scaleAspectFit
        }
        
        separatorView.do {
            $0.backgroundColor = .gray2
            $0.isHidden = false
        }
    }
    
    private func setUI() {
        contentView.addSubviews(thumnailImageView,
                                titleLabel,
                                infoHStackView,
                                chatAndLikeHStackView,
                                priceLabel,
                                menuIconImageView,
                                separatorView
        )
    }
    
    private func setLayout() {
        thumnailImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(108)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumnailImageView.snp.top)
            $0.leading.equalTo(thumnailImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(menuIconImageView.snp.leading).offset(-16)
        }
        
        menuIconImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        
        infoHStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.height.equalTo(16)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(infoHStackView.snp.bottom).offset(2)
            $0.leading.equalTo(infoHStackView.snp.leading)
        }
        
        chatAndLikeHStackView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(21)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(chatAndLikeHStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
        
    }
}

extension ProductCollectionViewCell {
    func configureUI(product: Product) {
        thumnailImageView.image = UIImage(named: product.thumbnailImageName)
        titleLabel.text = product.title
        priceLabel.text = product.price
        titleLabel.setAttributedText(lineHeight: 22)
        setupInfoStackView(distance: product.distance,
                           location: product.location,
                           time: product.time)
        configureChatAndLikeButtons(chatCount: product.chatCount,
                                    likeCount: product.likeCount)
    }
    
    private func setupInfoStackView(distance: String?, location: String, time: String) {
        infoHStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if let distance = distance {
            infoHStackView.addArrangedSubview(distanceImageView)
            distanceLabel.text = distance
            infoHStackView.addArrangedSubview(distanceLabel)
            addSeparatorIfNeeded(to: infoHStackView)
        }
        
        locationLabel.text = location
        infoHStackView.addArrangedSubview(locationLabel)
        addSeparatorIfNeeded(to: infoHStackView)
        
        timeLabel.text = time
        infoHStackView.addArrangedSubview(timeLabel)
    }
    
    private func configureChatAndLikeButtons(chatCount: Int?, likeCount: Int?) {
        chatAndLikeHStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if let chatCount = chatCount, chatCount > 0 {
               let attributedChatTitle = UIFont.sfProAttributedString(
                   text: "\(chatCount)",
                   style: .body_md_13_026,
                   color: .gray8
               )
               chatButton.setAttributedTitle(attributedChatTitle, for: .normal)
               chatAndLikeHStackView.addArrangedSubview(chatButton)
           }
           
           if let likeCount = likeCount, likeCount > 0 {
               let attributedLikeTitle = UIFont.sfProAttributedString(
                   text: "\(likeCount)",
                   style: .body_md_13_026,
                   color: .gray8
               )
               likeButton.setAttributedTitle(attributedLikeTitle, for: .normal)
               chatAndLikeHStackView.addArrangedSubview(likeButton)
           }
    }
    
    private func createSeparator() -> UIImageView {
        return UIImageView().then {
            $0.image = UIImage(systemName: "circle.fill")
            $0.tintColor = .gray
            $0.contentMode = .scaleAspectFit
            $0.snp.makeConstraints { $0.width.height.equalTo(4) }
        }
    }
    
    private func addSeparatorIfNeeded(to stackView: UIStackView) {
        let separator = createSeparator()
        stackView.addArrangedSubview(separator)
    }
}
