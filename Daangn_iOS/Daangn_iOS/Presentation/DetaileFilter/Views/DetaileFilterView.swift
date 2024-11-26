//
//  DetaileFilterView.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/24/24.
//

import UIKit

import SnapKit
import Then

protocol DetaileFilterViewDelegate {
    func didTapResetButton()
    func didTapApplyButton(selectedCells: [IndexPath])
}

final class DetaileFilterView: UIView {
    
    // MARK: - Delegate
    
    var delegate: DetaileFilterViewDelegate?
    var selectedCells: Set<IndexPath> = []
    
    // MARK: - UI Components
    
    private let navigationBar = DaangnNavigationBar(type: .normal)
    private let titleLabel = UILabel()
    lazy var tabbar = TopTabbar(type: .filter)
    private let bottomButtonView = UIView()
    private let resetButton = UIButton()
    private let applyButton = UIButton()
    
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
        
        bottomButtonView.do {
            $0.backgroundColor = .white
        }
        
        resetButton.do {
            $0.configuration = UIButton.Configuration.filled()
            $0.configuration?.baseBackgroundColor = .gray2
            $0.configuration?.baseForegroundColor = UIColor.black
            $0.configuration?.attributedTitle = AttributedString(
                "초기화",
                attributes: AttributeContainer([
                    .font: UIFont.sfPro(.body_bla_17),
                    .foregroundColor: UIColor.black
                ])
            )
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
            $0.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        }
        
        applyButton.do {
            $0.configuration = UIButton.Configuration.filled()
            $0.configuration?.baseBackgroundColor = .gray5
            $0.configuration?.attributedTitle = AttributedString(
                "적용하기",
                attributes: AttributeContainer([
                    .font: UIFont.sfPro(.body_bla_17),
                    .foregroundColor: UIColor.white
                ])
            )
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
        }
    }
    
    private func setHierarchy() {
        addSubviews(navigationBar, titleLabel, tabbar, bottomButtonView)
        bottomButtonView.addSubviews(resetButton, applyButton)
    }
    
    private func setLayout() {
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(13)
            $0.leading.equalToSuperview().inset(16)
        }
        
        tabbar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomButtonView.snp.top)
        }
        
        bottomButtonView.snp.makeConstraints {
            $0.height.equalTo(128)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        resetButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(53)
            $0.width.equalTo(109)
        }
        
        applyButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalTo(resetButton.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(53)
        }
    }
    
    func configureButtonStates() {
        self.applyButton.isEnabled = !self.selectedCells.isEmpty
        self.applyButton.configuration?.baseBackgroundColor = self.applyButton.isEnabled ? .orange1 : .gray5
        
    }
    
    @objc private func didTapResetButton() {
        selectedCells.removeAll()
        configureButtonStates()
        delegate?.didTapResetButton()
    }
    
    @objc private func didTapApplyButton() {
        delegate?.didTapApplyButton(selectedCells: Array(selectedCells))
    }
    
}
