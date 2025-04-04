//
//  ProductImageFooterReusableView.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/22/24.
//

import UIKit

import SnapKit
import Then

class ProductImageFooterReusableView: UICollectionReusableView {
    
    // MARK: - UI Component
    
    lazy var imageSlider = UIPageControl()
    
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

    // MARK: - UI&Layout
    
    private func setStyle() {
        backgroundColor = .clear
        
        imageSlider.do {
            $0.hidesForSinglePage = true
            $0.currentPageIndicatorTintColor = .white
            $0.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.2)
        }
    }
    
    private func setHierarchy() {
        addSubview(imageSlider)
    }
    
    private func setLayout() {
        imageSlider.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - updatePageIndex 
    
    private func updatePageIndex(_ page: Int) {
        imageSlider.currentPage = page
    }
}

// MARK: - ClassNameProtoco

extension ProductImageFooterReusableView: ClassNameProtocol { }

// MARK: - configure

extension ProductImageFooterReusableView {
    func configure(pageNumber: Int) {
        imageSlider.numberOfPages = pageNumber
    }
}

// MARK: - FooterScrollDelegate

extension ProductImageFooterReusableView: FooterScrollDelegate {
    func didScrollTo(page: Int) {
        updatePageIndex(page)
    }
}
