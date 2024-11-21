//
//  TopTabbar.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/21/24.
//

import UIKit

import SnapKit
import Then

enum TabbarType {
    case filter
    case search
}

final class TopTabbar: UIView {
    
    // MARK: - UI Components
    
    lazy var pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal,
        options: nil
    )
    private let flowLayout = UICollectionViewFlowLayout()
    lazy var tabbarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    let backgroundBar = UIView()
    let indicatorBar = UIView()
    
    // MARK: - Properties
    
    private var type: TabbarType?
    
    // MARK: - Life Cycles
    
    init(type: TabbarType) {
        super.init(frame: .zero)
        
        self.type = type
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setStyle() {
        backgroundColor = .white
        
        flowLayout.do {
            $0.scrollDirection = .horizontal
        }
        
        tabbarCollectionView.do {
            $0.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
        
        backgroundBar.do {
            $0.backgroundColor = .gray2
        }
        
        indicatorBar.do {
            $0.backgroundColor = .gray11
        }
    }
    
    func setHierarchy() {
        self.addSubviews(tabbarCollectionView, backgroundBar, indicatorBar, pageViewController.view)
    }
    
    func setLayout() {
        tabbarCollectionView.snp.makeConstraints {
            guard let type = type else { return }
            switch type {
            case .filter:
                $0.height.equalTo(44)
            case .search:
                $0.height.equalTo(42)
            }
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        backgroundBar.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(tabbarCollectionView.snp.bottom)
        }
        
        indicatorBar.snp.makeConstraints {
            $0.width.equalTo(0)
            $0.height.equalTo(2)
            $0.leading.equalToSuperview().offset(68)
            $0.bottom.equalTo(tabbarCollectionView.snp.bottom)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.height.equalTo(100).priority(.low)
            $0.top.equalTo(indicatorBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
