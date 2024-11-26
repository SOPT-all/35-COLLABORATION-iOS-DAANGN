//
//  RelatedSearchWordCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/27/24.
//

import UIKit

import SnapKit
import Then

final class RelatedSearchWordCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        contentView.do {
            $0.backgroundColor = .gray2
            $0.makeCornerRound(radius: 30 / 2)
        }
        
        titleLabel.do {
            $0.textColor = .gray8
            $0.font = .sfPro(.body_md_12)
        }
    }
    
    private func setHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.center.equalToSuperview()
        }
    }
}

extension RelatedSearchWordCollectionViewCell: ClassNameProtocol {
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
