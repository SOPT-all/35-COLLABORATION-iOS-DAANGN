//
//  ProductDetailViewController.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/20/24.
//

import UIKit

class ProductDetailViewController: UIViewController {

    private var sellerProducts = RelatedProduct.sampleSellerProducts
    private var relatedProducts = RelatedProduct.sampleRelatedArticle
    
    private let rootView = ProductDetailView()
    
    override func loadView() {
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
            ProductRelatedCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductRelatedCollectionViewCell.className
        )
    }
}

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let section = ProductDetailSection(rawValue: section)
        else {
            return 0
        }
        
        return section.numberOfItemsInSection
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let section = ProductDetailSection(rawValue: indexPath.section)
        else {
            fatalError()
        }
        
        switch section {
        case .relatedArticle:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductRelatedCollectionViewCell.className,
                for: indexPath
            ) as! ProductRelatedCollectionViewCell
            let model = relatedProducts[indexPath.row]
            cell.configure(with: model)
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductRelatedCollectionViewCell.className,
                for: indexPath
            ) as! ProductRelatedCollectionViewCell
            let model = sellerProducts[indexPath.row]
            cell.configure(with: model)
            
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ProductDetailSection.allCases.count
    }
    
}

extension ProductDetailViewController: UICollectionViewDelegate {
    
}
