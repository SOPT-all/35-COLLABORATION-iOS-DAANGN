//
//  SecondHandTradingViewController.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/27/24.
//

import UIKit

final class SecondHandTradingViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let rootView = SecondHandTradingView()
    private lazy var collectionView = rootView.collectionView
    
    // MARK: - Properties
    
    private let relatedSearchWordsData = RelatedSearchWordModel.mockData()
    private let filterData = HomeTag.allCases
    private let resultItems = ProductResponseDTO.sampleProducts
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setRegister()
        setNavigationBar()
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        collectionView.dataSource = self
    }

    private func setRegister() {
        collectionView.register(RelatedSearchWordCollectionViewCell.self, forCellWithReuseIdentifier: RelatedSearchWordCollectionViewCell.className)
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.className)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.className)
        
        collectionView.register(OnSaleFilterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OnSaleFilterCollectionReusableView.className)
        collectionView.register(DividerCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DividerCollectionReusableView.className)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}

extension SecondHandTradingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SecondHandTradingSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = SecondHandTradingSection.allCases[section]
        switch sectionType {
        case .relatedSearchWords:
            return relatedSearchWordsData.count
        case .filter:
            return filterData.count
        case .resultItems:
            return resultItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = SecondHandTradingSection.allCases[indexPath.section]
        switch sectionType {
        case .relatedSearchWords:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelatedSearchWordCollectionViewCell.className, for: indexPath) as? RelatedSearchWordCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.configure(title: relatedSearchWordsData[indexPath.item].title)
            return cell
        case .filter:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.className, for: indexPath) as? TagCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.configureUI(tagTitle: filterData[indexPath.item].rawValue)
            return cell
        case .resultItems:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.className, for: indexPath) as? ProductCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.configureUI(product: resultItems[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let sectionType = SecondHandTradingSection.allCases[indexPath.section]
            switch sectionType {
            case .resultItems:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: OnSaleFilterCollectionReusableView.className, for: indexPath) as? OnSaleFilterCollectionReusableView
                else { return UICollectionReusableView() }
                return header
            default:
                return UICollectionReusableView()
            }
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DividerCollectionReusableView.className, for: indexPath) as? DividerCollectionReusableView
            else { return UICollectionReusableView() }
            
            footer.configure(color: .gray2)
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}

//extension SecondHandTradingViewController: UICollectionViewCompositionalLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = relatedSearchWordsData[indexPath.item].title
//            .getLabelContentSize(withFont: .sfPro(.body_md_12)).width
//            + 12 * 2
//        return CGSize(
//            width: cellWidth,
//            height: collectionView.frame.height
//        )
//    }
//}
