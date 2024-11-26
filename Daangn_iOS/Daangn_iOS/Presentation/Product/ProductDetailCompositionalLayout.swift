//
//  ProductCompositionalLayout.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/19/24.
//

import UIKit

class ProductDetailCompositionalLayout {
    
    weak var connectDelegate: FooterConnectDelegate?
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            guard let section = ProductDetailSection(rawValue: sectionNumber)
            else { fatalError() }
            
            switch section {
            case .productImage:
                return self.productImageSectionLayout()
            case .sellerInfo:
                return self.sellerInfoSectionLayout()
            case .productDetailInfo:
                return self.productDetailInfoSectionLayout()
            case .sellerProduct:
                return self.sellerProductSectionLayout()
            case .keywordNotify:
                return self.keywordNotifySectionLayout()
            case .relatedArticle:
                return self.relatedArticleSectionLayout()
            }
        }
    }
}

// MARK: - Layout

extension ProductDetailCompositionalLayout {
    
    private func productImageSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(375)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        section.visibleItemsInvalidationHandler = { items, offset, environment in
            let page = Int(round(offset.x / environment.container.contentSize.width))
            self.connectDelegate?.connect(page: page)
        }
        
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(8)
            ),
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        footer.contentInsets = NSDirectionalEdgeInsets(top: -28, leading: 0, bottom: 8, trailing: 0)
        
        section.boundarySupplementaryItems = [footer]
        
        return section
    }
    
    private func sellerInfoSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(80)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func productDetailInfoSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(364)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func sellerProductSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(169)
            ),
            subitems: [item]
        )
        
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 20,
            trailing: 16
        )
        section.interGroupSpacing = 24

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(60)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func keywordNotifySectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(83)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func relatedArticleSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(169)
            ),
            subitems: [item]
        )
        
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
        section.interGroupSpacing = 24

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(50)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        section.boundarySupplementaryItems = [header]
        
        return section
    }
}
