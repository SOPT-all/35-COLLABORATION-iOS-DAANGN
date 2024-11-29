//
//  CategoryListViewController.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/24/24.
//

import UIKit

protocol CategoryCellSelectionToDetailFilterDelegate: NSObject {
    func categoryCellDidSelect(at indexPath: IndexPath)
    func categoryCellDidDeselect(at indexPath: IndexPath)
}

class CategoryListViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: CategoryCellSelectionToDetailFilterDelegate?
    var categories: [String] = []
    var selectedCategories: [Bool] = []
    
    // MARK: - UI Components
    
    lazy var categoryCollectionView: IntrinsicCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 26
        layout.sectionInset = UIEdgeInsets(top: 27, left: 0, bottom: 0, right: 0)
        return IntrinsicCollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setUI()
        setLayout()
        setDelegate()
        registerCells()
        fetchCategories()
    }
    
    private func setStyle() {
        view.backgroundColor = .white
        
        categoryCollectionView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
        }
    }
    
    private func setUI() {
        view.addSubview(categoryCollectionView)
    }
    
    private func setLayout() {
        categoryCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
    }
    
    func resetSelections() {
        for item in 0..<categories.count {
            let indexPath = IndexPath(item: item, section: 0)
            if let cell = categoryCollectionView.cellForItem(at: indexPath) as? CategoryListViewCell {
                cell.resetSelection()
            }
        }
        categoryCollectionView.reloadData()
    }
    
}

extension CategoryListViewController {
    private func fetchCategories() {
        DaangnService.shared.getCategoryList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let response = data as? BaseResponseModel<CategoryResponseDTO>,
                      let categories = response.result?.categories
                else {
                    print("⛔️ 데이터 형식이 맞지 않습니다.")
                    return
                }
                self.categories = categories
                
                // 선택 상태 배열 초기화
                self.selectedCategories = Array(repeating: false, count: self.categories.count)
                
                self.categoryCollectionView.reloadData()
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

private extension CategoryListViewController {
    
    func setDelegate() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    func registerCells() {
        categoryCollectionView.register(CategoryListViewCell.self, forCellWithReuseIdentifier: CategoryListViewCell.className)
    }
}

extension CategoryListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryListViewCell.className,
            for: indexPath
        ) as? CategoryListViewCell else {
            return UICollectionViewCell()
        }
        let category = categories[indexPath.item]
        cell.configureUI(category: category)
        cell.delegate = self
        
        // 선택 상태 반영
        cell.setSelectionState(selectedCategories[indexPath.item])
        
        return cell
    }

}

extension CategoryListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 22)
    }
}

extension CategoryListViewController: CategoryCellSelectionToCategoryListDelegate {
    func didToggleSelection(for cell: CategoryListViewCell, isSelected: Bool) {
        guard let indexPath = categoryCollectionView.indexPath(for: cell) else { return }
        
        // 선택 상태 배열 업데이트
        selectedCategories[indexPath.item] = isSelected
        if isSelected {
            delegate?.categoryCellDidSelect(at: indexPath)
        } else {
            delegate?.categoryCellDidDeselect(at: indexPath)
        }
    }
}
