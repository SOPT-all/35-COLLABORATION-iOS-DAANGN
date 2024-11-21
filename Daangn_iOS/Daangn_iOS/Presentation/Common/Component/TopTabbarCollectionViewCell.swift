//
//  TopTabbarCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class TopTabbarCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopTabbarCollectionViewCell"
    
    private let titleLabel = UILabel()
    
    private var type: TabbarType = .filter {
        didSet {
            titleLabel.snp.makeConstraints {
                switch type {
                case .filter:
                    $0.edges.equalToSuperview().inset(13)
                case .search:
                    $0.center.equalToSuperview()
                }
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .gray11 : .gray7
        }
    }
    
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
        titleLabel.do {
            $0.font = .sfPro(.body_md_13)
            $0.textColor = .gray7
        }
    }
    
    private func setHierarchy() {
        contentView.addSubviews(titleLabel)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension TopTabbarCollectionViewCell {
    
    func configure(type: TabbarType, title: String) {
        self.type = type
        titleLabel.text = title
    }
}
