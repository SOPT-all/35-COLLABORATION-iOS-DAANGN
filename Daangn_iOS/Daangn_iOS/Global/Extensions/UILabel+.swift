//
//  UILabel+.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/17/24.
//

import UIKit

extension UILabel {
    
    /// 자간, 행 높이, 밑줄 속성을 한번에 설정합니다. 원하는 일부 속성만 설정할 수 있습니다.
    func setAttributedText(
        letterSpacing: CGFloat? = nil,
        lineHeight: CGFloat? = nil,
        isUnderlined: Bool = false
    ) {
        guard let text = text else { return }
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let letterSpacing = letterSpacing {
            attributes.updateValue(letterSpacing, forKey: .kern)
        }
        if let lineHeight = lineHeight {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            attributes.updateValue(style, forKey: .paragraphStyle)
            attributes.updateValue((lineHeight - font.lineHeight) / 2, forKey: .baselineOffset)
        }
        if isUnderlined { attributes.updateValue(NSUnderlineStyle.single.rawValue, forKey: .underlineStyle)
        }
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }
}
