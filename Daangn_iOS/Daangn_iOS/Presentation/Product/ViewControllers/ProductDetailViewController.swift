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
    private var sampleUserInfo = UserInfoResponseDTO.sampleUserInfo
    private var sampleProductInfo = ProductInfo.productInfo
    var userInfo: UserInfoResponseDTO? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.rootView.collectionView.reloadData()
            }
        }
    }
    
    weak var delegate: FooterScrollDelegate?
    
    // MARK: - UI Component
    
    private lazy var rootView = ProductDetailView(viewController: self)
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserData()
        setDelegate()
        setRegister()
        fetchData()
        setNavigationBar()
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
            UserInfoCollectionViewCell.self,
            forCellWithReuseIdentifier: UserInfoCollectionViewCell.className
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
            HeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCollectionReusableView.className
        )
        
        rootView.collectionView.register(
            ProductImageFooterReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: ProductImageFooterReusableView.className
        )
    }
    
    private func fetchData() {
        let model = sampleProductInfo
        rootView.purchaseBottomView.configure(with: model)
    }
    
    private func fetchUserData() {
        DaangnService.shared.getUserProfile(userId: 1) { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success(let data):
                guard let data = data as? BaseResponseModel<UserInfoResponseDTO>,
                      let result = data.result
                else { return }
                
                self.userInfo = result
                
            case .requestErr:
                print("요청 오류 입니다")
            case .decodedErr:
                print("디코딩 오류 입니다")
            case .pathErr:
                print("경로 오류 입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
        
    }

    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
}

// MARK: - UICollectionViewDataSource

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        return ProductDetailSection.allCases[section].numberOfItemsInSection
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let section = ProductDetailSection.allCases[indexPath.section]
        
        switch section {
        case .productImage:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductImageCollectionViewCell.className,
                for: indexPath
            ) as? ProductImageCollectionViewCell
            else { return UICollectionViewCell() }
            
            return cell
        case .userInfo:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserInfoCollectionViewCell.className,
                for: indexPath
            ) as? UserInfoCollectionViewCell
            else { return UICollectionViewCell() }
            
            if let userInfo = self.userInfo {
                cell.configure(with: userInfo)
            } else {
                cell.configure(with: sampleUserInfo)
            }
            
            return cell
        case .productDetailInfo:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductDetailInfoCollectionViewCell.className,
                for: indexPath
            ) as? ProductDetailInfoCollectionViewCell
            else { return UICollectionViewCell() }
            
            let model = sampleProductInfo
            cell.configure(with: model)
            
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
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.className, for: indexPath) as? HeaderCollectionReusableView
            else { return UICollectionReusableView() }
            
            let sectionType = ProductDetailSection.allCases[indexPath.section]
            switch sectionType {
            case .sellerProduct:
                header.configure(
                    title: ProductDetailSection.allCases[indexPath.section].rawValue,
                    type: .product
                )
            case .relatedArticle:
                header.configure(
                    title: ProductDetailSection.allCases[indexPath.section].rawValue,
                    type: .product,
                    isMoreButtonIncluded: false
                )
            default:
                break
            }
            
            return header
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProductImageFooterReusableView.className,
                for: indexPath) as? ProductImageFooterReusableView
            else { return UICollectionReusableView() }
            
            self.delegate = footer
            footer.configure(pageNumber: ProductDetailSection.allCases[indexPath.section].numberOfItemsInSection)
            return footer
        default:
            return UICollectionReusableView()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ProductDetailSection.allCases.count
    }
}

// MARK: - UICollectionViewDelegate

extension ProductDetailViewController: UICollectionViewDelegate { }

// MARK: - FooterConnectDelgate

extension ProductDetailViewController: FooterConnectDelegate {
    func connect(page: Int) {
        delegate?.didScrollTo(page: page)
    }
}
