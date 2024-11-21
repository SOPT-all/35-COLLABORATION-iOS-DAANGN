//
//  HeaderCollectionReusableView.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/21/24.
//

import UIKit

import SnapKit
import Then

enum HeaderType {
    case product
    case profile
}

final class HeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private lazy var moreButton = UIButton()
        .then {
            addSubview($0)
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(16)
                switch type {
                case .product:
                    $0.size.equalTo(28)
                    $0.centerY.equalTo(titleLabel).offset(-1)
                case .profile:
                    $0.size.equalTo(18)
                    $0.centerY.equalTo(titleLabel).offset(-2)
                }
            }
        }
    
    // MARK: - Properties
    
    private var type: HeaderType = .product
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setStyle() {
        titleLabel.do {
            $0.textColor = .gray9
        }
    }
    
    private func setHierarchy() {
        addSubview(titleLabel)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}

// MARK: - Extensions

extension HeaderCollectionReusableView {
    
    func configure(
        with title: String,
        type: HeaderType,
        isMoreButtonIncluded: Bool = true
    ) {
        titleLabel.do {
            $0.text = title
            $0.font = UIFont.sfPro(.title_bla_15_22)
            $0.setAttributedText(lineHeight: 22)
        }
        self.type = type
        if isMoreButtonIncluded {
            moreButton.do {
                $0.contentMode = .scaleAspectFit
                switch type {
                case .product:
                    $0.setImage(.icDirectionRightBlackLg, for: .normal)
                case .profile:
                    $0.setImage(.icDirectionRightBlackSm, for: .normal)
                }
            }
        }
    }
}
