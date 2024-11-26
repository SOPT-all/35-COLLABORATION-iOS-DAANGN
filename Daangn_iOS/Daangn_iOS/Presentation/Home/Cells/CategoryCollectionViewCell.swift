//
//  CategoryCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/27/24.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell, ClassNameProtocol {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let deleteButton = UIButton()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Style
    
    private func setStyle() {
        contentView.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 16)
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray3.cgColor
        }
        
        titleLabel.do {
            $0.font = .sfPro(.body_md_12)
            $0.textColor = .orange1
            $0.textAlignment = .center
        }
        
        deleteButton.do {
            $0.setImage(UIImage(resource: .icDeleteOrange), for: .normal)
            $0.tintColor = .gray
            $0.contentMode = .scaleAspectFit
        }
    }
    
    // MARK: - Layout
    
    private func setLayout() {
        contentView.addSubviews(titleLabel, deleteButton)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(18)
        }
    }
    
    // MARK: - Configure
    
    func configureUI(category: String) {
        titleLabel.text = category
        titleLabel.setAttributedText(lineHeight: 12)
    }
}
