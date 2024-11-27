//
//  DaangnNavigationBar.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/20/24.
//

import UIKit

import SnapKit
import Then

enum NavigationBarType {
    case home
    case normal
    case search
    case product
    case profile
}

final class DaangnNavigationBar: UIView {
    
    // MARK: - UI Components
    
    private lazy var townLocationButton = UIButton()
        .then {
            $0.configuration = UIButton.Configuration.plain()
            $0.configuration?.baseForegroundColor = .gray11
            $0.configuration?.image = .icDirectionDown
            $0.configuration?.contentInsets = .zero
            $0.configuration?.imagePadding = 3
            $0.configuration?.imagePlacement = .trailing
            $0.configuration?.attributedTitle = AttributedString(
                UIFont.sfProAttributedString(
                    text: "가락2동",
                    style: .title_sb_17,
                    color: .gray11
                )
            )
        }
        .then {
            addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(16)
                $0.centerY.equalToSuperview()
            }
        }
    
    private lazy var searchButton = UIButton()
        .then {
            $0.setImage(.icSearch, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
    
    private lazy var menuButton = UIButton()
        .then {
            $0.setImage(.icMenuHamburger, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
    
    private lazy var notificationButton = UIButton()
        .then {
            $0.setImage(.icNotificationLg, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
    
    lazy var backButton = UIButton()
        .then {
            $0.setImage(
                self.type == .product ? .icDirectionLeftWhite : .icDirectionLeftBlack,
                for: .normal
            )
            $0.contentMode = .scaleAspectFit
        }
        .then {
            addSubview($0)
            $0.snp.makeConstraints {
                $0.size.equalTo(28)
                $0.leading.equalToSuperview().inset(
                    self.type == .normal ? 16 : 12
                )
                $0.centerY.equalToSuperview()
            }
        }
    
    private lazy var searchTextField = UITextField()
    
    
    private lazy var homeButton = UIButton()
        .then {
            $0.setImage(.icHomeWhite, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
        .then {
            addSubview($0)
            $0.snp.makeConstraints {
                $0.size.equalTo(28)
                $0.leading.equalToSuperview().inset(55)
                $0.centerY.equalToSuperview()
            }
        }
    
    private lazy var shareButton = UIButton()
        .then {
            $0.setImage(
                self.type == .product ? .icShareWhite : .icShareBlack,
                for: .normal
            )
            $0.contentMode = .scaleAspectFit
        }
        .then {
            addSubview($0)
            $0.snp.makeConstraints {
                $0.size.equalTo(28)
                $0.trailing.equalToSuperview().inset(61)
                $0.centerY.equalToSuperview()
            }
        }
    
    private lazy var kebabButton = UIButton()
        .then {
            $0.setImage(
                self.type == .product ? .icMenuKebabWhite : .icMenuKebabBlack,
                for: .normal
            )
            $0.contentMode = .scaleAspectFit
        }
        .then {
            addSubview($0)
            $0.snp.makeConstraints {
                $0.size.equalTo(24)
                $0.trailing.equalToSuperview().inset(18)
                $0.centerY.equalToSuperview()
            }
        }
    
    private lazy var titleLabel = UILabel()
        .then {
            $0.text = "프로필"
            $0.font = .sfPro(.title_md_18_036)
            $0.setAttributedText(letterSpacing: -0.36)
        }
        .then {
            addSubview($0)
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    
    private lazy var stackViewOf3 = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.spacing = 6
            $0.addArrangeSubViews(searchButton, menuButton, notificationButton)
        }
        .then {
            addSubview($0)
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(17)
                $0.centerY.equalToSuperview()
            }
        }
    
    // MARK: - Properties
    
    private let type: NavigationBarType
    private var includedComponents: [UIView] = []
    
    // MARK: - Life Cycles
    
    init(type: NavigationBarType) {
        self.type = type
        super.init(frame: .zero)
        backgroundColor = .white
        
        switch type {
        case .home:
            includedComponents = [townLocationButton, stackViewOf3]
        case .normal:
            includedComponents = [backButton]
        case .search:
            includedComponents = [backButton, searchTextField]
        case .product:
            includedComponents = [backButton, homeButton, shareButton, kebabButton]
        case .profile:
            includedComponents = [backButton, titleLabel, shareButton, kebabButton]
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
