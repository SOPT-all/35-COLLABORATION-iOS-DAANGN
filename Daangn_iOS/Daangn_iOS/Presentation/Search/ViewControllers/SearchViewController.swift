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
    
    private let tabbarData = TopTabbarModel.searchTopTabbarData()
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
        
        setDelegate()
        setRegister()
        setPageViewController()
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
    
    private func setDelegate() {
        tabbarCollectionView.delegate = self
        tabbarCollectionView.dataSource = self
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }

    private func setRegister() {
        // TODO: className으로 변경
        tabbarCollectionView.register(TopTabbarCollectionViewCell.self, forCellWithReuseIdentifier: TopTabbarCollectionViewCell.identifier)
    }
    
    private func setPageViewController() {
        addViewControllersData()
        let secondVC = viewControllers[1]
        pageViewController.setViewControllers([secondVC], direction: .forward, animated: true)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Extensions

private extension SearchViewController {
    
    func addViewControllersData() {
        for _ in 0 ..< tabbarData.count {
            let vc = UIViewController()
            vc.view.backgroundColor = .gray1
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabbarCollectionViewCell.identifier, for: indexPath) as? TopTabbarCollectionViewCell
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
