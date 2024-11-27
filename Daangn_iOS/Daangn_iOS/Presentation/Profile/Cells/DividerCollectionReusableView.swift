//
//  DividerCollectionReusableView.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/25/24.
//

import UIKit

import SnapKit
import Then

final class DividerCollectionReusableView: UICollectionReusableView {
        
    private let divider = UIView()
    
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
        divider.do {
            $0.backgroundColor = .gray3
        }
    }
    
    private func setHierarchy() {
        addSubview(divider)
    }
    
    private func setLayout() {
        divider.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension DividerCollectionReusableView: ClassNameProtocol {
    
    func configure(color: UIColor) {
        divider.backgroundColor = color
    }
}
