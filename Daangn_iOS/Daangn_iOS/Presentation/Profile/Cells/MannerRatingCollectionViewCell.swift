//
//  MannerRatingCollectionViewCell.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class MannerRatingCollectionViewCell: UICollectionViewCell {
    
    private let peopleImageView = UIImageView()
    private let countLabel = UILabel()
    private let grayBackgroundView = UIView()
    private let mannerContentLabel = UILabel()
    
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
        peopleImageView.do {
            $0.image = .icPeople
            $0.contentMode = .scaleAspectFit
        }
        
        countLabel.do {
            $0.textColor = .gray11
            $0.font = .sfPro(.body_hv_16)
        }
        
        grayBackgroundView.do {
            $0.backgroundColor = .gray2
            $0.roundCorners(
                radius: 12,
                to: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
            )
        }
        
        mannerContentLabel.do {
            $0.textColor = .gray9
            $0.font = .sfPro(.title_bla_15_22)
        }
    }
    
    private func setHierarchy() {
        contentView.addSubviews(peopleImageView, countLabel, grayBackgroundView)
        grayBackgroundView.addSubview(mannerContentLabel)
    }
    
    private func setLayout() {
        peopleImageView.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalTo(countLabel)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(peopleImageView.snp.trailing).offset(7)
        }
        
        grayBackgroundView.snp.makeConstraints {
            $0.top.equalTo(countLabel)
            $0.leading.equalToSuperview().inset(87)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        mannerContentLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(14)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.center.equalToSuperview()
        }
    }
}

extension MannerRatingCollectionViewCell: ClassNameProtocol {
    
    func configure(count: Int, title: String) {
        countLabel.text = "\(count)"
        mannerContentLabel.text = title
        mannerContentLabel.setAttributedText(lineHeight: 22)
    }
}
