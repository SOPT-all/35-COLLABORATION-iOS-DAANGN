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
    let categorys: [CatogoriesResponseDTO] = CatogoriesResponseDTO.sampleCategories
    
    // MARK: - UI Components
    
    lazy var filterCollectionView: IntrinsicCollectionView = {
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
    }
    
    private func setStyle() {
        view.backgroundColor = .white
        
        filterCollectionView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
        }
    }
    
    private func setUI() {
        view.addSubview(filterCollectionView)
    }
    
    private func setLayout() {
        filterCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
    }
    
    func resetSelections() {
        for item in 0..<categorys.count {
            let indexPath = IndexPath(item: item, section: 0)
            if let cell = filterCollectionView.cellForItem(at: indexPath) as? CategoryListViewCell {
                cell.resetSelection() // 버튼이미지 리셋
            }
        }
        filterCollectionView.reloadData()
    }
    
}

private extension CategoryListViewController {
    
    func setDelegate() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    func registerCells() {
        filterCollectionView.register(CategoryListViewCell.self, forCellWithReuseIdentifier: CategoryListViewCell.className)
    }
}

extension CategoryListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryListViewCell.className,
            for: indexPath
        ) as? CategoryListViewCell else {
            return UICollectionViewCell()
        }
        let category = categorys[indexPath.item]
        cell.configureUI(category: category)
        cell.delegate = self // 델리게이트 설정
        
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
        guard let indexPath = filterCollectionView.indexPath(for: cell) else { return }
        
        if isSelected {
            delegate?.categoryCellDidSelect(at: indexPath)
        } else {
            delegate?.categoryCellDidDeselect(at: indexPath)
        }
    }
}
