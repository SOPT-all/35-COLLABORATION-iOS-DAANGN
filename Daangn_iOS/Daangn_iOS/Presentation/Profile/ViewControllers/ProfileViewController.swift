//
//  ProfileViewController.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let rootView = ProfileView()
    private lazy var collectionView = rootView.collectionView
    
    // MARK: - Properties
    
    private let userId: Int
    private var profileData: UserInfoResponseDTO?
    private var mannerRatingData = MannerRatingModel.mockData()
    private var tradeReviewData = TradeReviewModel.mockData()
    
    // MARK: - Life Cycles
    
    init(userId: Int) {
        self.userId = userId
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
        
        fetchData()
        setDelegate()
        setRegister()
        setNavigationBar()
    }
    
    // MARK: - Methods
    
    private func fetchData() {
        DaangnService.shared.getUserProfile(userId: userId) { [weak self] response in
            guard let self  = self else { return }
            
            switch response {
            case .success(let data):
                guard let data = data as? BaseResponseModel<UserInfoResponseDTO>,
                      let result = data.result
                else { return }
                
                profileData = result
                collectionView.reloadSections([0, 2])
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setRegister() {
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.className)
        collectionView.register(MannerTemperatureCollectionViewCell.self, forCellWithReuseIdentifier: MannerTemperatureCollectionViewCell.className)
        collectionView.register(VerificationInfoCollectionViewCell.self, forCellWithReuseIdentifier: VerificationInfoCollectionViewCell.className)
        collectionView.register(BadgeCollectionViewCell.self, forCellWithReuseIdentifier: BadgeCollectionViewCell.className)
        collectionView.register(MannerRatingCollectionViewCell.self, forCellWithReuseIdentifier: MannerRatingCollectionViewCell.className)
        collectionView.register(TradeReviewCollectionViewCell.self, forCellWithReuseIdentifier: TradeReviewCollectionViewCell.className)
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.className)
        collectionView.register(DividerCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DividerCollectionReusableView.className)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ProfileSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = ProfileSection.allCases[section]
        switch sectionType {
        case .profile, .mannerTemperature, .verificationInfo, .badge:
            return 1
        case .itemsForSale:
            return 0
        case .mannerRating:
            return mannerRatingData.count
        case .tradeReview:
            return tradeReviewData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = ProfileSection.allCases[indexPath.section]
        switch sectionType {
        case .profile:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.className, for: indexPath) as? ProfileCollectionViewCell
            else { return UICollectionViewCell() }
            
            if let profileData = profileData {
                cell.configure(
                    profileImage: profileData.profile_image,
                    nickname: profileData.nickname
                )
            }
            return cell
        case .mannerTemperature:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MannerTemperatureCollectionViewCell.className, for: indexPath) as? MannerTemperatureCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
        case .verificationInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerificationInfoCollectionViewCell.className, for: indexPath) as? VerificationInfoCollectionViewCell
            else { return UICollectionViewCell() }
            
            if let profileData = profileData {
                cell.configure(address: profileData.address)
            }
            return cell
        case .badge:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCollectionViewCell.className, for: indexPath) as? BadgeCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
        case .itemsForSale:
            return UICollectionViewCell()
        case .mannerRating:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MannerRatingCollectionViewCell.className, for: indexPath) as? MannerRatingCollectionViewCell
            else { return UICollectionViewCell() }
            
            let data = mannerRatingData[indexPath.item]
            cell.configure(count: data.ratingCount, title: data.mannerType)
            return cell
        case .tradeReview:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TradeReviewCollectionViewCell.className, for: indexPath) as? TradeReviewCollectionViewCell
            else { return UICollectionViewCell() }
            
            let data = tradeReviewData[indexPath.item]
            cell.configure(with: data)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.className, for: indexPath) as? HeaderCollectionReusableView
            else { return UICollectionReusableView() }
            
            header.configure(
                title: ProfileSection.allCases[indexPath.section].rawValue,
                type: .profile
            )
            return header
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DividerCollectionReusableView.className, for: indexPath) as? DividerCollectionReusableView
            else { return UICollectionReusableView() }
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate {}
