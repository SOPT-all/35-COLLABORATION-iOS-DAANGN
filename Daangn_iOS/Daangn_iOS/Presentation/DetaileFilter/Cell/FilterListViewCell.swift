//
//  FilterListViewCell.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/24/24.
//

import UIKit

final class FilterListViewCell: UICollectionViewCell {
    
    static let identifier = "FilterListViewCell"
    
    // MARK: - UI Components
    
    private let selectButton = UIButton()
    private let titleLabel = UILabel()

    // MARK: - Properties
    
    private var isButtonSelected: Bool = false {
        didSet {
            updateButtonImage()
        }
    }

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setStyle() {
        contentView.do {
            $0.backgroundColor = .white
        }
        
        titleLabel.do {
            $0.font = .sfPro(.title_bla_15_22)
            $0.textColor = .black
            $0.textAlignment = .center
        }
        
        selectButton.do {
            $0.setImage(UIImage(named: "ic_checkbox_normal"), for: .normal)
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setUI() {
        contentView.addSubviews(selectButton, titleLabel)
    }
    
    private func setLayout() {
        
        selectButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(22)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(selectButton.snp.trailing).offset(13)
        }
    }

    private func setActions() {
        selectButton.addTarget(self, action: #selector(toggleButtonState), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func toggleButtonState() {
        isButtonSelected.toggle()
    }
    
    private func updateButtonImage() {
        let imageName = isButtonSelected ? "ic_checkbox_selected" : "ic_checkbox_normal"
        selectButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

// MARK: - Extension for Configuration

extension FilterListViewCell {
    func configureUI(category: CategoryResponseDTO) {
        titleLabel.text = category.name
        titleLabel.setAttributedText(lineHeight: 22)
    }
}
