//
//  ProductDetailViewController.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/20/24.
//

import UIKit

class ProductDetailViewController: UIViewController {

    // MARK: - Properties
    
    private var sellerProducts = RelatedProduct.sampleSellerProducts
    private var relatedProducts = RelatedProduct.sampleRelatedArticle
    
    // MARK: - UI Component
    
    private let rootView = ProductDetailView()
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setRegister()
    }
    
    private func setDelegate() {
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
    }
    
    private func setRegister() {
        
        rootView.collectionView.register(
            ProductImageCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductImageCollectionViewCell.className
        )
        
        rootView.collectionView.register(
            SellerInfoCollectionViewCell.self,
            forCellWithReuseIdentifier: SellerInfoCollectionViewCell.className
        )
        
        rootView.collectionView.register(
            ProductDetailInfoCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductDetailInfoCollectionViewCell.className
        )
        
        rootView.collectionView.register(
            ProductRelatedCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductRelatedCollectionViewCell.className
        )
        
        rootView.collectionView.register(
            KeywordNotifyCollectionViewCell.self,
            forCellWithReuseIdentifier: KeywordNotifyCollectionViewCell.className
        )
        
        rootView.collectionView.register(
            ProductRelatedHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProductRelatedHeaderCell.className
        )
    }
}

// MARK: - UICollectionViewDataSource

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let section = ProductDetailSection(rawValue: section)
        else { return 0 }
        
        return section.numberOfItemsInSection
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let section = ProductDetailSection(rawValue: indexPath.section)
        else { fatalError() }
        
        switch section {
        case .productImage:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductImageCollectionViewCell.className,
                for: indexPath
            ) as? ProductImageCollectionViewCell
            else { return UICollectionViewCell() }
            
            return cell
        case .sellerInfo:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SellerInfoCollectionViewCell.className,
                for: indexPath
            ) as? SellerInfoCollectionViewCell
            else { return UICollectionViewCell() }
            
            return cell
        case .productDetailInfo:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductDetailInfoCollectionViewCell.className,
                for: indexPath
            ) as? ProductDetailInfoCollectionViewCell
            else { return UICollectionViewCell() }
            
            return cell
        case .sellerProduct:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductRelatedCollectionViewCell.className,
                for: indexPath
            ) as? ProductRelatedCollectionViewCell
            else { return UICollectionViewCell() }
            
            let model = sellerProducts[indexPath.row]
            cell.configure(with: model)
            
            return cell
        case .keywordNotify:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: KeywordNotifyCollectionViewCell.className,
                for: indexPath
            ) as? KeywordNotifyCollectionViewCell
            else { return UICollectionViewCell() }
            
            return cell
        case .relatedArticle:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductRelatedCollectionViewCell.className,
                for: indexPath
            ) as? ProductRelatedCollectionViewCell
            else { return UICollectionViewCell() }
            
            let model = relatedProducts[indexPath.row]
            cell.configure(with: model)
            
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProductRelatedHeaderCell.className,
                for: indexPath
            ) as? ProductRelatedHeaderCell,
                  let section = ProductDetailSection(rawValue: indexPath.section)
            else { return UICollectionReusableView() }
            
            switch section {
            case .sellerProduct:
                header.configure(title: "헿헿님의 판매 물품")
            case .relatedArticle:
                header.configure(title: "이 글과 함께 봤어요")
            default:
                header.configure(title: "")
            }
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ProductDetailSection.allCases.count
    }
    
}

// MARK: - UICollectionViewDelegate

extension ProductDetailViewController: UICollectionViewDelegate {
    
}