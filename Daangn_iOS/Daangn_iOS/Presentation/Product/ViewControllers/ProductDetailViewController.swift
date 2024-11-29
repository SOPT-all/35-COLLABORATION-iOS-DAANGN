//
//  ProductDetailViewController.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/20/24.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: FooterScrollDelegate?
    private var userId: Int
    private let productId: Int
    private var relatedProducts = UserSellingProductResponseDTO.sampleRelatedArticle
    
    private var userInfo: UserInfoResponseDTO? {
        didSet {
            reloadCollectionView(sections: [1, 3])
        }
    }
    
    private var userSellingProduct: UserSellingProductResponseDTO? {
        didSet {
            reloadCollectionView(sections: [3])
        }
    }
    
    private var productInfo: ProductDetailResponseDTO? {
        didSet {
            reloadCollectionView(sections: [0, 2, 4])
        }
    }
    
    // MARK: - UI Component
    
    private lazy var rootView = ProductDetailView(viewController: self)
    
    // MARK: - View Life Cycle
    
    init(userId: Int, productId: Int) {
        self.userId = userId
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setRegister()
        setNavigationBar()
        setButtonAction()
        fetchUserInfo()
        fetchProductInfo()
        fetchSellingProduct()
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
    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setButtonAction() {
        rootView.navigationBar.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - colletionView reload
    
    private func reloadCollectionView(sections: IndexSet) {
        DispatchQueue.main.async { [weak self] in
            self?.rootView.collectionView.reloadData()
//            self?.rootView.collectionView.reloadSections(sections)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let sectionType = ProductDetailSection.allCases[section]
        switch sectionType {
        case .productImage, .relatedArticle:
            return 4
        case .sellingProduct:
            return userSellingProduct?.products.count ?? 0
        default:
            return 1
        }
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
            
            if let model = self.productInfo {
                cell.configure(with: model)
            }
            
            return cell
        case .userInfo:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserInfoCollectionViewCell.className,
                for: indexPath
            ) as? UserInfoCollectionViewCell
            else { return UICollectionViewCell() }
            
            if let model = self.userInfo {
                cell.configure(with: model)
            }
            
            return cell
        case .productDetailInfo:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductDetailInfoCollectionViewCell.className,
                for: indexPath
            ) as? ProductDetailInfoCollectionViewCell
            else { return UICollectionViewCell() }
            
            if let model = self.productInfo {
                cell.configure(with: model)
            }
            
            return cell
        case .sellingProduct:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductRelatedCollectionViewCell.className,
                for: indexPath
            ) as? ProductRelatedCollectionViewCell
            else { return UICollectionViewCell() }
            
            if let model = self.userSellingProduct?.products[indexPath.item] {
                cell.configure(with: model)
            }
            
            return cell
        case .keywordNotify:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: KeywordNotifyCollectionViewCell.className,
                for: indexPath
            ) as? KeywordNotifyCollectionViewCell
            else { return UICollectionViewCell() }
            
            if let model = self.productInfo {
                cell.configure(with: model)
            }
            
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
            case .sellingProduct:
                if let model = self.userInfo {
                    header.configure(
                        title: "\(model.nickname)님의 판매 물품",
                        type: .product
                    )
                }
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
            footer.configure(pageNumber: 4)
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

extension ProductDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if ProductDetailSection.allCases[indexPath.section] == .userInfo {
            let profileViewController = ProfileViewController(userId: userId)
            navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
}

// MARK: - FooterConnectDelgate

extension ProductDetailViewController: FooterConnectDelegate {
    func connect(page: Int) {
        delegate?.didScrollTo(page: page)
    }
}

// MARK: - Network

extension ProductDetailViewController {
    private func fetchUserInfo() {
        DaangnService.shared.getUserProfile(userId: userId) { [weak self] response in
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
    
    private func fetchProductInfo() {
        DaangnService.shared.getPostDetails(productId: productId) { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success(let data):
                guard let data = data as? BaseResponseModel<ProductDetailResponseDTO>,
                      let result = data.result
                else { return }
                
                self.productInfo = result
                self.rootView.purchaseBottomView.configure(with: result)
                
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
    
    private func fetchSellingProduct() {
        DaangnService.shared.getUserItemList(userId: userId) { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success(let data):
                guard let data = data as? BaseResponseModel<UserSellingProductResponseDTO>,
                      let result = data.result
                else { return }
                
                self.userSellingProduct = result
                
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
}


