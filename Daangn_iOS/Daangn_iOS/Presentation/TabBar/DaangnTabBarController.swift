//
//  DaangnTabBarController.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/29/24.
//

import UIKit

import Then

final class DaangnTabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTabBarControllers()
    }
}

// MARK: - Methods

extension DaangnTabBarController {
    
    private func setUI() {
        tabBar.do {
            $0.backgroundColor = .white
            $0.tintColor = .gray9
            $0.unselectedItemTintColor = .gray9
            $0.layer.borderColor = UIColor.gray4.cgColor
            $0.layer.borderWidth = 0.5
            $0.layer.frame = CGRect(
                x: 0,
                y: 0,
                width: $0.frame.size.width,
                height: 1
            )
        }
    }
    
    private func setTabBarControllers() {
        let tabBarItems: [DaangnTabBarItem] = [
            .home,
            .townLife,
            .townMap,
            .chat,
            .myDaangn
        ]
        
        viewControllers = tabBarItems.map { item in
            return templateNavigationController(
                title: item.title,
                unselectedImage: item.unselectedImage,
                selectedImage: item.selectedImage,
                rootViewController: item.viewController
            )
        }
    }
    
    private func templateNavigationController(
        title: String,
        unselectedImage: UIImage?,
        selectedImage: UIImage?,
        rootViewController: UIViewController
    ) -> UINavigationController {
        return UINavigationController(rootViewController: rootViewController).then {
            $0.title = title
            $0.tabBarItem.image = unselectedImage
            $0.tabBarItem.selectedImage = selectedImage
            $0.navigationBar.isHidden = true
        }
    }
}
