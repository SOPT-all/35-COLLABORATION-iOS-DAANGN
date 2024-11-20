//
//  ProductDetailView.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/20/24.
//

import UIKit

import SnapKit
import Then

class ProductDetailView: UIView {

    // MARK: - Properties
    
    private let layout = ProductDetailCompositionalLayout.createLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI&Layout
    
    private func setStyle() {
        collectionView.do {
            $0.backgroundColor = .clear
        }
    }
    
    private func setUI() {
        addSubview(collectionView)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
