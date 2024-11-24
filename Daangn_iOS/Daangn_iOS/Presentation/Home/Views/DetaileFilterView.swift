//
//  DetaileFilterView.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/24/24.
//

import UIKit

import SnapKit
import Then

final class DetaileFilterView: UIView {

    // MARK: - UI Components
    
    private let navigationBar = DaangnNavigationBar(type: .normal)
    private let titleLabel = UILabel()
    lazy var tabbar = TopTabbar(type: .filter)

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

    // MARK: - Methods

    private func setStyle() {
        backgroundColor = .white
        
        titleLabel.do {
            $0.font = .sfPro(.title_md_23)
            $0.text = "상세필터"
            $0.textColor = .black
        }
    }

    private func setHierarchy() {
        addSubviews(navigationBar, titleLabel, tabbar)
    }

    private func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(16)
        }
        
        tabbar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
    }
}
