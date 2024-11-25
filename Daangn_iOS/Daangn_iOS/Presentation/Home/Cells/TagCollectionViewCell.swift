//
//  TagCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/20/24.
//

import UIKit

final class TagCollectionViewCell: UICollectionViewCell, ClassNameProtocol {

    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let dropdownImageView = UIImageView()
    
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
        
        contentView.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 16)
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray3.cgColor
        }
        
        titleLabel.do {
            $0.font = .sfPro(.body_md_12)
            $0.textColor = .black
            $0.textAlignment = .center
        }
        
        dropdownImageView.do {
            $0.image = .icDirectionDown
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setUI() {
        contentView.addSubviews(titleLabel, dropdownImageView)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
        }
        
        dropdownImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(18)
        }
    }
}

extension TagCollectionViewCell {
    func configureUI(tagTitle: String) {
        titleLabel.text = tagTitle
        titleLabel.setAttributedText(lineHeight: 12)
    }
}
