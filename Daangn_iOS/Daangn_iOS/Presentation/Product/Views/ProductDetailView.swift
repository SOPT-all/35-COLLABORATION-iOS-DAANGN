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

    private let layout = ProductDetailCompositionalLayout.createLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
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
    
    func setStyle() {
        collectionView.do {
            $0.backgroundColor = .clear
        }
    }
    
    func setUI() {
        addSubview(collectionView)
    }
    
    func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
