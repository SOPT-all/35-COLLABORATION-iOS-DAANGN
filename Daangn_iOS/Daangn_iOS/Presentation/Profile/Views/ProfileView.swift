//
//  ProfileView.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

import SnapKit
import Then

enum ProfileSection: String, CaseIterable {
    case profile
    case mannerTemperature
    case verificationInfo
    case badge = "활동 배지 17개"
}

final class ProfileView: UIView {
    
    private let navigationBar = DaangnNavigationBar(type: .profile)
    private let divider = UIView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: setSectionLayout())
    
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
        backgroundColor = .white
        
        divider.do {
            $0.backgroundColor = .gray4
        }
        
        collectionView.do {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    private func setHierarchy() {
        addSubviews(navigationBar, divider, collectionView)
    }
    
    private func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

private extension ProfileView {
    
    func setSectionLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
            let sectionType = ProfileSection.allCases[sectionIndex]
            switch sectionType {
            case .profile, .mannerTemperature, .verificationInfo, .badge:
                return self.profileSectionLayout(type: sectionType)
            }
        }
        
        return layout
    }
    
    private func profileSectionLayout(type: ProfileSection) -> NSCollectionLayoutSection {
        var heightDimension: NSCollectionLayoutDimension
        switch type {
        case .profile:
            heightDimension = .estimated(140)
        case .mannerTemperature:
            heightDimension = .estimated(182)
        case .verificationInfo:
            heightDimension = .estimated(91)
        case .badge:
            heightDimension = .estimated(115)
        }
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: heightDimension
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: heightDimension
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        if type == .badge {
            let header = profileSectionHeader()
            section.boundarySupplementaryItems = [header]
        }

        return section
    }
    
    func profileSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
       let header = NSCollectionLayoutBoundarySupplementaryItem(
           layoutSize: NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1),
               heightDimension: .estimated(62)
           ),
           elementKind: UICollectionView.elementKindSectionHeader,
           alignment: .top
       )
       return header
    }
}
