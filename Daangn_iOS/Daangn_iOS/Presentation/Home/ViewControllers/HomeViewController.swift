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
    private let writeButton = UIButton()
    
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
    
        writeButton.do {
            $0.configuration = UIButton.Configuration.plain()
            $0.configuration?.baseForegroundColor = .white
            $0.configuration?.image = UIImage(resource: .icPlusSm)
            $0.configuration?.imagePadding = 4
            $0.configuration?.imagePlacement = .leading
            $0.configuration?.attributedTitle = AttributedString(
                "글쓰기",
                attributes: AttributeContainer([
                    .font: UIFont.sfPro(.title_bla_15_22),
                    .foregroundColor: UIColor.white
                ])
            )
            $0.backgroundColor = .orange1
            $0.layer.cornerRadius = 25
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.2
            $0.layer.shadowOffset = CGSize(width: 0, height: 4)
            $0.layer.shadowRadius = 6
        }
        
    }
    
    private func setUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            navigationBar,
            resetButton,
            tagCollectionView,
            productCollectionView,
            writeButton
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
        
        writeButton.snp.makeConstraints {
            $0.trailing.equalTo(scrollView.frameLayoutGuide.snp.trailing).offset(-13)
               $0.bottom.equalTo(scrollView.frameLayoutGuide.snp.bottom).offset(-102)
               $0.height.equalTo(46)
               $0.width.equalTo(98)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffsetY = scrollView.contentOffset.y

        UIView.animate(withDuration: 0.3) {
            if scrollOffsetY > 50 {
                self.writeButton.configuration?.attributedTitle = nil
                self.writeButton.configuration?.image = UIImage(resource: .icPlusLg)
                self.writeButton.configuration?.imagePlacement = .leading
                self.writeButton.configuration?.imagePadding = 0
                self.writeButton.snp.updateConstraints {
                    $0.width.height.equalTo(58)
                }
                self.writeButton.layer.cornerRadius = 29
            } else {
                self.writeButton.configuration?.attributedTitle = AttributedString(
                    "글쓰기",
                    attributes: AttributeContainer([
                        .font: UIFont.sfPro(.title_bla_15_22),
                        .foregroundColor: UIColor.white
                    ])
                )
                self.writeButton.configuration?.image = UIImage(resource: .icPlusSm) 
                self.writeButton.configuration?.imagePlacement = .leading
                self.writeButton.configuration?.imagePadding = 4
                self.writeButton.snp.updateConstraints {
                    $0.height.equalTo(46)
                    $0.width.equalTo(98)
                }
                self.writeButton.layer.cornerRadius = 25
            }
            self.view.layoutIfNeeded()
        }
    }
}

private extension HomeViewController {
    
    func setDelegate() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        scrollView.delegate = self
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

