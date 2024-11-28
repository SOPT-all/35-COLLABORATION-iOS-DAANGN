//
//  SearchViewController.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let rootView = SearchView()
    private lazy var tabbarCollectionView = rootView.tabbar.tabbarCollectionView
    private lazy var pageViewController = rootView.tabbar.pageViewController
    
    // MARK: - Properties
    
    private weak var delegate: SearchResultDelegate?
    private var searchKeyword = "" {
        didSet {
            fetchData()
        }
    }
    private let tabbarData = TopTabbarModel.searchTopTabbarData()
    
    /// 상단탭바 UI 관련 프로퍼티
    private var viewControllers: [UIViewController] = []
    private let tabbarCellHorizontalPadding: CGFloat = 13 * 2
    private var currentTabbarIndex: Int = 1 {
        didSet {
            moveIndicatorbar(to: currentTabbarIndex)
        }
    }
    private var currentPageIndex = 1 {
        didSet {
            setPageVC(from: oldValue, to: currentPageIndex)
        }
    }
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setDelegate()
        setRegister()
        setPageViewController()
        setButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        moveIndicatorbar(to: 1)
    }
    
    // MARK: - Methods
    
    private func fetchData() {
        DaangnService.shared.getSearchProducts(keyword: searchKeyword) { [weak self] response in
            guard let self  = self else { return }
            
            switch response {
            case .success(let data):
                guard let data = data as? BaseResponseModel<SearchResponseDTO>,
                      let result = data.result
                else { return }
                
                delegate?.bindSearchResult(
                    keyword: searchKeyword,
                    products: result.products,
                    similarProducts: result.similar_products
                )
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
    
    private func setDelegate() {
        tabbarCollectionView.delegate = self
        tabbarCollectionView.dataSource = self
        pageViewController.delegate = self
        pageViewController.dataSource = self
        rootView.navigationBar.searchTextField.delegate = self
    }

    private func setRegister() {
        tabbarCollectionView.register(TopTabbarCollectionViewCell.self, forCellWithReuseIdentifier: TopTabbarCollectionViewCell.className)
    }
    
    private func setPageViewController() {
        addViewControllersData()
        let secondVC = viewControllers[1]
        pageViewController.setViewControllers([secondVC], direction: .forward, animated: true)
    }
    
    private func setButtonAction() {
        rootView.navigationBar.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extensions

private extension SearchViewController {
    
    func addViewControllersData() {
        for index in 0 ..< tabbarData.count {
            let vc: UIViewController
            if index == 1 {
                vc = SecondHandTradingViewController()
                self.delegate = vc as? any SearchResultDelegate
            } else {
                vc = UIViewController()
                vc.view.backgroundColor = .gray1
            }
            viewControllers.append(vc)
        }
    }
    
    func setIndicatorBarIndex(to newIndex: Int) {
        self.currentTabbarIndex = newIndex
    }
    
    func setPageIndex(to newIndex: Int) {
        self.currentPageIndex = newIndex
    }
    
    func moveIndicatorbar(to newIndex: Int) {
        let indexPath = IndexPath(item: newIndex, section: 0)
        tabbarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        guard let cell = tabbarCollectionView.cellForItem(at: indexPath) as? TopTabbarCollectionViewCell else { return }
        
        rootView.tabbar.indicatorBar.snp.remakeConstraints {
            $0.width.equalTo(cell.contentView.bounds.width)
            $0.height.equalTo(2)
            $0.bottom.equalTo(tabbarCollectionView.snp.bottom)
            $0.centerX.equalTo(cell)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setPageVC(from currentIndex: Int, to newIndex: Int) {
        guard 0 <= newIndex && newIndex < viewControllers.count else { return }
        let direction: UIPageViewController.NavigationDirection = currentIndex < newIndex ? .forward : .reverse
        pageViewController.setViewControllers([viewControllers[newIndex]], direction: direction, animated: true)
        setIndicatorBarIndex(to: newIndex)
    }
    
    func checkIfBarAndPageAreInSameIndex(for currentIndex: Int) -> Bool {
        return currentTabbarIndex == currentIndex
    }
}

extension SearchViewController: ProductCellTapDelegate {
    
    func productCellDidTap(userId: Int, productId: Int) {
        let productDetailViewController = ProductDetailViewController(userId: userId, productId: productId)
        navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let keyword = textField.text else { return false }
        self.searchKeyword = keyword
        return true
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newIndex = indexPath.item
        self.currentTabbarIndex = newIndex
        setPageIndex(to: newIndex)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabbarData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabbarCollectionViewCell.className, for: indexPath) as? TopTabbarCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(type: .search, title: tabbarData[indexPath.item].title)
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = tabbarData[indexPath.item].title
            .getLabelContentSize(withFont: .sfPro(.body_md_13)).width
            + tabbarCellHorizontalPadding
        return CGSize(
            width: cellWidth,
            height: collectionView.frame.height
        )
    }
}

extension SearchViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let newVC = pendingViewControllers.first,
              let newIndex = viewControllers.firstIndex(of: newVC)
        else { return }
        setIndicatorBarIndex(to: newIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentPageIndex = viewControllers.firstIndex(of: currentVC)
        else { return }
        if !checkIfBarAndPageAreInSameIndex(for: currentPageIndex) {
            setIndicatorBarIndex(to: currentPageIndex)
        }
    }
}

extension SearchViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        return previousIndex < 0 ? nil : viewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        return nextIndex == viewControllers.count ? nil : viewControllers[nextIndex]
    }
}
