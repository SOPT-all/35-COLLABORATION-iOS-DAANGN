//
//  ProductRelatedCell.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/19/24.
//

import UIKit

import SnapKit
import Then

class ProductRelatedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let relatedSalesImageView = UIImageView()
    private let relatedSalesTitleLabel = UILabel()
    private let relatedSalesPriceLabel = UILabel()
    
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
        relatedSalesImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.makeCornerRound(radius: 6)
        }
        
        relatedSalesTitleLabel.do {
            $0.textColor = .gray9
            $0.font = .sfPro(.body_md_13)
            $0.numberOfLines = 1
        }
        
        relatedSalesPriceLabel.do {
            $0.textColor = .gray9
            $0.font = .sfPro(.body_hv_14)
        }
    }
    
    private func setHierarchy() {
        contentView.addSubviews(relatedSalesImageView, relatedSalesTitleLabel, relatedSalesPriceLabel)
    }
    
    private func setLayout() {
        relatedSalesImageView.snp.makeConstraints {
            $0.height.equalTo(124)
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        relatedSalesTitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(relatedSalesImageView.snp.bottom).offset(8)
        }
        
        relatedSalesPriceLabel.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(relatedSalesTitleLabel.snp.bottom).offset(4)
        }
    }
}

// MARK: - Configure

extension ProductRelatedCollectionViewCell {
    
    func configure(with product: SellingProduct) {
        relatedSalesImageView.kf.setImage(with: URL(string: product.product_image))
        relatedSalesTitleLabel.text = product.title
        relatedSalesPriceLabel.text = "\(product.price)원"
    }
}

// MARK: - ClassNameProtocol

extension ProductRelatedCollectionViewCell: ClassNameProtocol { }
