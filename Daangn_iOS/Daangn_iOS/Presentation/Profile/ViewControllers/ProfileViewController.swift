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
    
    private var profileData = ProfileModel.mockData()
    private var mannerRatingData = MannerRatingModel.mockData()
    private var tradeReviewData = TradeReviewModel.mockData()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setRegister()
        setNavigationBar()
    }
    
    // MARK: - Methods
    
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
            cell.configure(with: profileData)
            return cell
        case .mannerTemperature:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MannerTemperatureCollectionViewCell.className, for: indexPath) as? MannerTemperatureCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
        case .verificationInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerificationInfoCollectionViewCell.className, for: indexPath) as? VerificationInfoCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
        case .badge:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCollectionViewCell.className, for: indexPath) as? BadgeCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
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
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.className, for: indexPath) as? HeaderCollectionReusableView
        else { return UICollectionReusableView() }
        
        header.configure(
            title: ProfileSection.allCases[indexPath.section].rawValue,
            type: .profile
        )
        return header
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
}
