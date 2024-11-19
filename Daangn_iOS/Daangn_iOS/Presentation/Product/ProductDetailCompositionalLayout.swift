//
//  ProductCompositionalLayout.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/19/24.
//

import UIKit

struct ProductDetailCompositionalLayout {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection
            
            if sectionNumber == 0 {
                
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    ),
                    subitems: [item]
                )
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                
            } else if sectionNumber == 1 || sectionNumber == 4 {
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(80)
                    ),
                    subitems: [item]
                )
                
                section = NSCollectionLayoutSection(group: group)
            } else if sectionNumber == 2 {
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(364)
                    ),
                    subitems: [item]
                )
                
                section = NSCollectionLayoutSection(group: group)
            } else {
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(362)
                    ),
                    subitems: [item]
                )
                
                section = NSCollectionLayoutSection(group: group)
                
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(50)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )

                section.boundarySupplementaryItems = [header]
            }
            return section
        }
    }
}
