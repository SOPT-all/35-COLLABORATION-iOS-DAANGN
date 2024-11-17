//
//  UIStackView+.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/17/24.
//

import UIKit

extension UIStackView {
    
    func addArrangeSubViews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
