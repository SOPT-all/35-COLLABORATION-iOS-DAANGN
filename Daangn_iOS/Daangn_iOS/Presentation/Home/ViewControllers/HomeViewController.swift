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
    
    let tags: [HomeTagResponseDTO] = HomeTagResponseDTO.sampleTags
    let products: [ProductResponseDTO] = ProductResponseDTO.sampleProducts
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let resetButton = UIButton()
    
    private lazy var tagCollectionView: IntrinsicCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = IntrinsicCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var productCollectionView: IntrinsicCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = IntrinsicCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let navigationBar = DaangnNavigationBar(type: .home)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setUI()
        setLayout()
        setDelegate()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
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
    }
    
    private func setUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            navigationBar,
            resetButton,
            tagCollectionView,
            productCollectionView
        )
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(scrollView).offset(16)
            $0.leading.trailing.equalTo(scrollView)
            $0.height.equalTo(28)
        }
        
        resetButton.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(34)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.centerY.equalTo(resetButton)
            $0.leading.equalTo(resetButton.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(34)
        }
        
        productCollectionView.snp.makeConstraints {
            $0.top.equalTo(tagCollectionView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

private extension HomeViewController {
    
    func setDelegate() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }
    
    func registerCells() {
        tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return tags.count
        } else if collectionView == productCollectionView {
            return products.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
                return UICollectionViewCell()
            }
            let tag = tags[indexPath.item]
            cell.configureUI(tag: tag)
            return cell
        } else if collectionView == productCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
                return UICollectionViewCell()
            }
            let product = products[indexPath.item]
            cell.configureUI(product: product)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tagCollectionView {
            let tag = tags[indexPath.item]
            let estimatedWidth = calculateDynamicWidth(for: tag.title, font: .sfPro(.body_md_12))
            return CGSize(width: estimatedWidth, height: 34)
        } else if collectionView == productCollectionView {
            return CGSize(width: collectionView.frame.width, height: 162)
        }
        return CGSize.zero
    }
    
    private func calculateDynamicWidth(for text: String, font: UIFont) -> CGFloat {
        let padding: CGFloat = 50
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 34)
        let attributes = [NSAttributedString.Key.font: font]
        let textWidth = (text as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).width
        return textWidth + padding
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tagCollectionView {
            let selectedTag = tags[indexPath.item]
            navigateToCategoryScreen(with: selectedTag)
        }
    }
}

private extension HomeViewController {
    func navigateToCategoryScreen(with tag: HomeTagResponseDTO) {
        let detaileFilterController = DetaileFilterViewController()
        navigationController?.pushViewController(detaileFilterController, animated: true)
    }
}

