//
//  FilterListViewCell.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/24/24.
//

import UIKit

protocol CategoryListViewCellDelegate: AnyObject {
    func didToggleSelection(for cell: CategoryListViewCell, isSelected: Bool)
}

final class CategoryListViewCell: UICollectionViewCell, ClassNameProtocol {
    
    // MARK: - Properties
    
    weak var delegate: CategoryListViewCellDelegate?
    
    private var isButtonSelected: Bool = false {
        didSet {
            updateButtonImage()
            delegate?.didToggleSelection(for: self, isSelected: isButtonSelected)
        }
    }
    
    // MARK: - UI Components
    
    private let selectButton = UIButton()
    private let titleLabel = UILabel()
    
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
    
    // MARK: - Actions
    
    private func setActions() {
        selectButton.addTarget(self, action: #selector(toggleButtonState), for: .touchUpInside)
    }
    
    @objc private func toggleButtonState() {
        isButtonSelected.toggle()
    }
    
    private func updateButtonImage() {
        selectButton.setImage( isButtonSelected ? .icCheckboxSelected : .icCheckboxNormal, for: .normal )
    }
    
    func resetSelection() {
        isButtonSelected = false
    }
}

extension CategoryListViewCell {
    func configureUI(category: catogoriesResponseDTO) {
        titleLabel.text = category.name
        titleLabel.setAttributedText(lineHeight: 22)
    }
}
