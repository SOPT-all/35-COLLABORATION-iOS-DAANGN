//
//  FilterListViewCell.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/24/24.
//

import UIKit

protocol CategoryCellSelectionToCategoryListDelegate: AnyObject {
    func didToggleSelection(for cell: CategoryListViewCell, isSelected: Bool)
}

final class CategoryListViewCell: UICollectionViewCell, ClassNameProtocol {
    
    // MARK: - Properties
    
    weak var delegate: CategoryCellSelectionToCategoryListDelegate?
    
    private var isButtonSelected: Bool = false {
        didSet {
            selectButton.setImage(
                isButtonSelected ? .icCheckboxSelected : .icCheckboxNormal,
                for: .normal
            )
            delegate?.didToggleSelection(for: self, isSelected: isButtonSelected)
        }
    }
    
    // MARK: - UI Components
    
    private let selectButton = UIButton()
    private let titleLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        contentView.backgroundColor = .white
        
        titleLabel.font = .sfPro(.title_bla_15_22)
        titleLabel.textColor = .black
        
        selectButton.setImage(UIImage(named: "ic_checkbox_normal"), for: .normal)
        selectButton.contentMode = .scaleAspectFit
        
        contentView.addSubviews(selectButton, titleLabel)
    }
    
    private func setupLayout() {
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
    
    private func setupActions() {
        selectButton.addTarget(self, action: #selector(toggleButtonState), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func toggleButtonState() {
        setSelectionState(!isButtonSelected)
    }
    
    func setSelectionState(_ isSelected: Bool) {
        isButtonSelected = isSelected
    }
    
    func resetSelection() {
        setSelectionState(false)
    }
    
}

extension CategoryListViewCell {
    
    func configureUI(category: String) {
        titleLabel.text = category
        titleLabel.setAttributedText(lineHeight: 22)
    }
}
