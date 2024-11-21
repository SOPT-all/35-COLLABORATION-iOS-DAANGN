//
//  String+.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/22/24.
//

import UIKit

extension String {
    
    func getLabelContentSize(withFont font: UIFont) -> CGSize {
        let label = UILabel()
        label.font = font
        label.text = self
        return label.intrinsicContentSize
    }
}
