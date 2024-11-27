//
//  SearchView.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class SearchView: UIView {
    
    // MARK: - UI Components
    
    let navigationBar = DaangnNavigationBar(type: .search)
    lazy var tabbar = TopTabbar(type: .search)
    
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
    
    // MARK: - Methods
    
    private func setStyle() {
        backgroundColor = .white
    }
    
    private func setHierarchy() {
        addSubviews(navigationBar, tabbar)
    }
    
    private func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.height.equalTo(42)
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        tabbar.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
