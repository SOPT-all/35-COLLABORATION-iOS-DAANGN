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
    
    private let layout = ProductDetailCompositionalLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout.createLayout())
    private let productDetailViewController: ProductDetailViewController
    
    // MARK: - View Life Cycle
    init(viewController: ProductDetailViewController) {
        self.productDetailViewController = viewController
        super.init(frame: .zero)
        
        setDelegate()
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI&Layout
    
    private func setDelegate() {
        layout.connectDelegate = productDetailViewController
    }
    
    private func setStyle() {
        backgroundColor = .white
        
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
