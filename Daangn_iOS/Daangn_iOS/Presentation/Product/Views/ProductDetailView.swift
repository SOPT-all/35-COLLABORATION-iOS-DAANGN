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
    let purchaseBottomView = PurchaseBottomView()
    private let productDetailViewController: ProductDetailViewController
    private let navigationBar = DaangnNavigationBar(type: .product)
    
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
        
        navigationBar.do {
            $0.backgroundColor = .clear
        }
        
        collectionView.do {
            $0.backgroundColor = .clear
            $0.contentInsetAdjustmentBehavior = .never
        }
    }
    
    private func setUI() {
        addSubviews(collectionView, purchaseBottomView, navigationBar)
    }
    
    private func setLayout() {
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        purchaseBottomView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(106)
        }
    }
}
