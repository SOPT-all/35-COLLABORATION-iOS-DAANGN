//
//  FilterListViewController.swift
//  Daangn_iOS
//
//  Created by 정정욱 on 11/24/24.
//

import UIKit

class CategoryListViewController: UIViewController {
    
    // MARK: - Properties
    
    let categorys: [CategoryResponseDTO] = CategoryResponseDTO.sampleCategories
    
    // MARK: - UI Components
    
    private lazy var filterCollectionView: IntrinsicCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 26
        layout.sectionInset = UIEdgeInsets(top: 27, left: 0, bottom: 0, right: 0)
        let collectionView = IntrinsicCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
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
}


private extension CategoryListViewController {
    
    func setDelegate() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    func registerCells() {
        filterCollectionView.register(FilterListViewCell.self, forCellWithReuseIdentifier: FilterListViewCell.identifier)
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
            withReuseIdentifier: FilterListViewCell.identifier,
            for: indexPath
        ) as? FilterListViewCell else {
            return UICollectionViewCell()
        }
        let category = categorys[indexPath.item]
        cell.configureUI(category: category)
        return cell
    }
}

extension CategoryListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 22)
    }
}

