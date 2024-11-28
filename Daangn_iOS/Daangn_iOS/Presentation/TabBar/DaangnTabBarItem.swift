//
//  DaangnTabBarItem.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/29/24.
//

import UIKit

enum DaangnTabBarItem {
    case home
    case townLife
    case townMap
    case chat
    case myDaangn
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .townLife:
            return "동네생활"
        case .townMap:
            return "동네지도"
        case .chat:
            return "채팅"
        case .myDaangn:
            return "나의 당근"
        }
    }
    
    var unselectedImage: UIImage {
        switch self {
        case .home:
            return .icHomeWhite
        case .townLife:
            return .icBottombarLife
        case .townMap:
            return .icBottombarMap
        case .chat:
            return .icBottombarChat
        case .myDaangn:
            return .icBottombarMypage
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .home:
            return .icBottombarHome
        case .townLife:
            return .icBottombarLife
        case .townMap:
            return .icBottombarMap
        case .chat:
            return .icBottombarChat
        case .myDaangn:
            return .icBottombarMypage
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home:
            return HomeViewController()
        default:
            return ViewController().then { $0.view.backgroundColor = .gray1 }
        }
    }
}
