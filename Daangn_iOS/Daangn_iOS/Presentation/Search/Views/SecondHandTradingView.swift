//
//  SecondHandTradingView.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/27/24.
//

import UIKit

import SnapKit
import Then

enum SecondHandTradingSection: CaseIterable {
    case relatedSearchWords
    case filter
    case resultItems
//    case similarItems
}

final class SecondHandTradingView: UIView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: setSectionLayout())
    private let getKeywordNotificationButton = UIButton()
    
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
        
        collectionView.do {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
        
        getKeywordNotificationButton.do {
            var config = UIButton.Configuration.filled()
            config.image = .icNotificationSmWhite
            config.imagePlacement = .leading
            config.imagePadding = 4
            config.attributedTitle = AttributedString(
                UIFont.sfProAttributedString(
                    text: I18N.Search.getNotification,
                    style: .body_md_13_026,
                    color: .white,
                    letterSpacing: -0.26
                )
            )
            config.contentInsets = .init(top: 8, leading: 15, bottom: 10, trailing: 19)
            config.baseBackgroundColor = .gray9
            $0.configuration = config
            $0.makeCornerRound(radius: 36 / 2)
        }
    }
    
    private func setHierarchy() {
        addSubviews(collectionView, getKeywordNotificationButton)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        getKeywordNotificationButton.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.bottom.equalTo(collectionView.contentLayoutGuide.snp.bottom).inset(68)
            $0.centerX.equalToSuperview()
        }
    }
}

private extension SecondHandTradingView {
    
    func setSectionLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
            let sectionType = SecondHandTradingSection.allCases[sectionIndex]
            switch sectionType {
            case .relatedSearchWords, .filter:
                return self.chipsSectionLayout(type: sectionType)
            case .resultItems:
                return self.resultItemsSectionLayout()
            }
        }
        
        return layout
    }
    
    func chipsSectionLayout(type: SecondHandTradingSection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(100),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let heightDimension: NSCollectionLayoutDimension
        switch type {
        case .relatedSearchWords:
            heightDimension = .estimated(30)
        case .filter:
            heightDimension = .estimated(34)
        default:
            heightDimension = .absolute(0)
        }
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(100),
            heightDimension: heightDimension
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(
            top: type == .filter ? 12 : 16,
            leading: 16,
            bottom: type == .filter ? 12 : 16,
            trailing: 16
        )
        if type == .relatedSearchWords {
            let footer = dividerFooter()
            footer.contentInsets = .init(
                top: 0,
                leading: -16,
                bottom: 0,
                trailing: -16
            )
            section.boundarySupplementaryItems = [footer]
        }
        
        return section
    }
    
    func resultItemsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(343)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(343)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
//        if type == .relatedSearchWords {
            let header = resultItemsSectionHeader()
            let footer = dividerFooter()
            section.boundarySupplementaryItems = [header, footer]
//        }
        
        return section
    }
    
    func resultItemsSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(28)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return header
     }
    
    func dividerFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
       let footer = NSCollectionLayoutBoundarySupplementaryItem(
           layoutSize: NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1),
               heightDimension: .absolute(8)
           ),
           elementKind: UICollectionView.elementKindSectionFooter,
           alignment: .bottom
       )
       return footer
    }
}
