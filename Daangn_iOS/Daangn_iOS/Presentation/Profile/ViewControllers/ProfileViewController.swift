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