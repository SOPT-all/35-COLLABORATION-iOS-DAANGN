//
//  HomeViewController.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/18/24.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    // MARK: - Mock Data
    
    private var categories: [String] = []
    private let tags: [HomeTag] = Array(HomeTag.allCases)
    private var products: [Product] = []
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let resetButton = UIButton()
    private let writeButton = UIButton()
    
    private var tagCollectionView: IntrinsicCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        return IntrinsicCollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var categoryCollectionView: IntrinsicCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        return IntrinsicCollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var productCollectionView: IntrinsicCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        return IntrinsicCollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let navigationBar = DaangnNavigationBar(type: .home)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchProducts()
        setStyle()
        setUI()
        setLayout()
        setDelegate()
        registerCells()
        setButtonAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        productCollectionView.invalidateIntrinsicContentSize()
        scrollView.invalidateIntrinsicContentSize()
        view.layoutIfNeeded()
    }
    
    // MARK: - Layout
    
    private func setStyle() {
        view.backgroundColor = .white
        
        resetButton.do {
            $0.layer.cornerRadius = 20
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray3.cgColor
            $0.backgroundColor = .white
            $0.setImage(.icReset, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
        }
        
        writeButton.do {
            $0.configuration = UIButton.Configuration.plain()
            $0.configuration?.image = UIImage(resource: .icPlusSm)
            $0.configuration?.imagePadding = 4
            $0.configuration?.imagePlacement = .leading
            $0.configuration?.attributedTitle = AttributedString(
                UIFont.sfProAttributedString(
                    text: "글쓰기",
                    style: .title_bla_15_22,
                    color: .white,
                    lineHeight: 22
                ))
            $0.backgroundColor = .orange1
            $0.makeCornerRound(radius: 46 / 2)
            $0.makeShadow(radius: 6, offset: CGSize(width: 0, height: 4), opacity: 0.2)
        }
        
        tagCollectionView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
        }
        
        categoryCollectionView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .gray3
        }
        
        productCollectionView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
        }
    }
    
    private func setUI() {
        view.addSubviews(navigationBar, scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            resetButton,
            tagCollectionView,
            categoryCollectionView,
            productCollectionView,
            writeButton
        )
    }
    
    private func setLayout() {
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        resetButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(34)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.centerY.equalTo(resetButton)
            $0.leading.equalTo(resetButton.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(34)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(resetButton.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54)
        }
        
        productCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints {
            $0.trailing.equalTo(scrollView.frameLayoutGuide.snp.trailing).offset(-13)
            $0.bottom.equalTo(scrollView.frameLayoutGuide.snp.bottom).offset(-102)
            $0.height.equalTo(46)
            $0.width.equalTo(98)
        }
        
        updateCategoryCollectionViewHeight()
    }
    
    // MARK: - Actions
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffsetY = scrollView.contentOffset.y
        
        writeButton.do {
            if scrollOffsetY > 50 {
                $0.configuration?.attributedTitle = nil
                $0.configuration?.image = UIImage(resource: .icPlusLg)
                $0.configuration?.imagePlacement = .leading
                $0.configuration?.imagePadding = 0
                $0.snp.updateConstraints {
                    $0.width.height.equalTo(58)
                }
                $0.layer.cornerRadius = 58 / 2
            } else {
                $0.configuration?.attributedTitle = AttributedString(
                    "글쓰기",
                    attributes: AttributeContainer([
                        .font: UIFont.sfPro(.title_bla_15_22),
                        .foregroundColor: UIColor.white
                    ])
                )
                $0.configuration?.image = UIImage(resource: .icPlusSm)
                $0.configuration?.imagePlacement = .leading
                $0.configuration?.imagePadding = 4
                $0.snp.updateConstraints {
                    $0.height.equalTo(46)
                    $0.width.equalTo(98)
                }
                $0.layer.cornerRadius = 46 / 2
            }
        }
        view.layoutIfNeeded()
    }
    
    func updateCategoryCollectionViewHeight() {
        let height: CGFloat = categories.count > 0 ? 54 : 0
        categoryCollectionView.snp.updateConstraints {
            $0.top.equalTo(resetButton.snp.bottom).offset(
                categories.count > 0 ? 12 : 2
            )
            $0.height.equalTo(height)
        }
        self.view.layoutIfNeeded()
    }
}

//MARK: API

extension HomeViewController {
    
    private func fetchProducts() {
        let categoryList = categories
        DaangnService.shared.getProductList(categoryList: categoryList) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let response = data as? BaseResponseModel<ProductResponseDTO>,
                      let productList = response.result?.products else {
                    print("⛔️ 데이터 형식이 맞지 않습니다.")
                    return
                }
                products = productList
                productCollectionView.reloadData()
            case .requestErr:
                print("⛔️ 요청 에러 발생 (400-499)")
            case .serverErr:
                print("⛔️ 서버 에러 발생 (500)")
            case .networkFail:
                print("⛔️ 네트워크 실패")
            case .pathErr:
                print("⛔️ 경로 에러 또는 디코딩 실패")
            default:
                print("⛔️ 알 수 없는 에러")
            }
        }
    }
}

private extension HomeViewController {
    func setDelegate() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        scrollView.delegate = self
    }
    
    func registerCells() {
        tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.className)
        productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.className)
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.className)
    }
    
    func setButtonAction() {
        navigationBar.searchButton.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
    }
    
    @objc func searchButtonDidTap() {
        let searchViewController = SearchViewController()
        searchViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchViewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return HomeTag.allCases.count
        } else if collectionView == productCollectionView {
            return products.count
        } else if collectionView == categoryCollectionView {
            return categories.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.className, for: indexPath) as? TagCollectionViewCell else {
                return UICollectionViewCell()
            }
            let tagTitle = HomeTag.allCases[indexPath.item].rawValue
            cell.configureUI(tagTitle: tagTitle)
            return cell
        } else if collectionView == productCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.className, for: indexPath) as? ProductCollectionViewCell else {
                return UICollectionViewCell()
            }
            let product = products[indexPath.item]
            cell.configureUI(product: product)
            return cell
        } else if collectionView == categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.className, for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let category = categories[indexPath.item]
            cell.delegate = self
            cell.configureUI(category: category)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tagCollectionView {
            let tagTitle = HomeTag.allCases[indexPath.item].rawValue
            let textSize = tagTitle.getLabelContentSize(withFont: .sfPro(.body_md_12))
            let padding: CGFloat = 50
            return CGSize(width: textSize.width + padding, height: 34)
        }
        else if collectionView == productCollectionView {
            return CGSize(width: collectionView.frame.width, height: 162)
        }
        else if collectionView == categoryCollectionView {
            let categoryTitle = categories[indexPath.item]
            let textSize = categoryTitle.getLabelContentSize(withFont: .sfPro(.body_md_12))
            let padding: CGFloat = 50
            return CGSize(width: textSize.width + padding, height: 34)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoryCollectionView {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        return UIEdgeInsets.zero
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tagCollectionView {
            navigateToDetailFilterViewController()
        }
    }
}

private extension HomeViewController {
    func navigateToDetailFilterViewController() {
        let detailFilterController = DetailFilterViewController()
        detailFilterController.delegate = self
        detailFilterController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailFilterController, animated: true)
    }
}

extension HomeViewController: ApplyFiltersToHomeDelegate {
    func applyFiltersToHomeView(selectedCategories: [String]) {
        categories = selectedCategories
        categoryCollectionView.reloadData()
        updateCategoryCollectionViewHeight()
        fetchProducts()
    }
}

extension HomeViewController: CategoryCollectionViewCellDelegate {
    
    func deleteButtonDidTap(for category: String) {
        guard let index = categories.firstIndex(of: category) else { return }
        categories.remove(at: index)
        categoryCollectionView.reloadData()
        updateCategoryCollectionViewHeight()
        fetchProducts()
    }
}
