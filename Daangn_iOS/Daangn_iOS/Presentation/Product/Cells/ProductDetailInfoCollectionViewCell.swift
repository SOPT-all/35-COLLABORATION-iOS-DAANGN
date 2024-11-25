//
//  ProductDetailInfoCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/21/24.
//

import UIKit

import SnapKit
import Then

class ProductDetailInfoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Component
    
    private let titleLabel = UILabel()
    private let categoryTimeLabel = UILabel()
    private let timeLabel = UILabel()
    private let contentLabel = UILabel()
    private let interestViewLabel = UILabel()
    private let reportButton = UIButton()
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
        
        titleLabel.do {
            $0.font = .sfPro(.title_md_19_038)
            $0.textColor = .black
        }
        
        categoryTimeLabel.do {
            $0.font = .sfPro(.body_md_13_026)
            $0.textColor = .gray6
        }
        
        contentLabel.do {
            $0.numberOfLines = 0
            $0.font = .sfPro(.title_bla_15_22)
            $0.textColor = .gray9
        }
        
        interestViewLabel.do {
            $0.font = .sfPro(.body_md_13_026)
            $0.textColor = .gray6
        }
        
        reportButton.do {
            $0.setTitle("이 게시글 신고하기", for: .normal)
            $0.setTitleColor(.gray6, for: .normal)
            $0.titleLabel?.font = .sfPro(.body_md_14_028)
            $0.titleLabel?.setAttributedText(letterSpacing: -0.28)
        }
        
        horizontalDivider.do {
            $0.backgroundColor = .gray3
        }
    }
    
    private func setHierarchy() {
        addSubviews(titleLabel, categoryTimeLabel, contentLabel, interestViewLabel, reportButton, horizontalDivider)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.leading.equalToSuperview().offset(16)
        }
        
        categoryTimeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.leading.equalTo(titleLabel)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(categoryTimeLabel.snp.bottom).offset(36)
            $0.leading.equalTo(titleLabel)
        }
        
        interestViewLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel)
        }
        
        reportButton.snp.makeConstraints {
            $0.top.equalTo(interestViewLabel.snp.bottom).offset(30)
            $0.leading.equalTo(titleLabel)
        }
        
        horizontalDivider.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(reportButton.snp.bottom).offset(22)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - ClassNameProtocol

extension ProductDetailInfoCollectionViewCell: ClassNameProtocol { }

// MARK: - configure

extension ProductDetailInfoCollectionViewCell {
    func configure(with product: ProductInfo) {
        titleLabel.text = product.title
        titleLabel.setAttributedText(letterSpacing: -0.38)
        categoryTimeLabel.text = "\(product.category) · 끌올 18시간 전"
        categoryTimeLabel.setAttributedText(letterSpacing: -0.26)
        contentLabel.text = product.content
        contentLabel.setAttributedText(lineHeight: 22)
        interestViewLabel.text = "관심 9 · \(product.view)"
        interestViewLabel.setAttributedText(letterSpacing: -0.26)
    }
}
