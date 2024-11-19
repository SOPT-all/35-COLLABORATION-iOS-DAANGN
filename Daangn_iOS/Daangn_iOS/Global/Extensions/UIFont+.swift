//
//  UIFont+.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/17/24.
//

import UIKit

enum FontName {
    case title_md_23, title_md_19_038, title_md_18_036, title_sb_17, title_bla_15
    case body_bla_17, body_bla_16, body_hv_16, body_sb_16, body_md_16, body_md_15, body_md_15_22, body_bla_14, body_hv_14, body_md_14_028, body_b_13_026, body_md_13, body_md_13_026, body_md_13_052, body_b_12, body_md_12, body_md_12_20, body_md_12_024
    case caption_md_14_028, caption_r_12_05, caption_r_12_08, caption_b_11, caption_md_11, caption_sb_9

    var weight: UIFont.Weight {
        switch self {
        case .title_bla_15, .body_bla_17, .body_bla_16, .body_bla_14:
            return .black
        case .body_hv_16, .body_hv_14:
            return .heavy
        case .body_b_13_026, .body_b_12, .caption_b_11:
            return .bold
        case .title_sb_17, .body_sb_16, .caption_sb_9:
            return .semibold
        case .title_md_23, .title_md_19_038, .title_md_18_036, .body_md_16, .body_md_15, .body_md_15_22, .body_md_14_028, .body_md_13, .body_md_13_026, .body_md_13_052, .body_md_12, .body_md_12_20, .body_md_12_024, .caption_md_14_028, .caption_md_11:
            return .medium
        case .caption_r_12_05, .caption_r_12_08:
            return .regular
        }
    }
    
    var size: CGFloat {
        switch self {
        case .title_md_23:
            return 23
        case .title_md_19_038:
            return 19
        case .title_md_18_036:
            return 18
        case .title_sb_17, .body_bla_17:
            return 17
        case .body_bla_16, .body_hv_16, .body_sb_16, .body_md_16:
            return 16
        case .title_bla_15, .body_md_15, .body_md_15_22:
            return 15
        case .body_bla_14, .body_hv_14, .body_md_14_028, .caption_md_14_028:
            return 14
        case .body_b_13_026, .body_md_13, .body_md_13_026, .body_md_13_052:
            return 13
        case .body_b_12, .body_md_12, .body_md_12_20, .body_md_12_024, .caption_r_12_05, .caption_r_12_08:
            return 12
        case .caption_b_11, .caption_md_11:
            return 11
        case .caption_sb_9:
            return 9
        }
    }
}

extension UIFont {
    
    static func sfPro(_ style: FontName) -> UIFont {
        return UIFont.systemFont(ofSize: style.size, weight: style.weight)
    }
    
    static func sfProAttributedString(
        text: String,
        style: FontName,
        color: UIColor,
        letterSpacing: CGFloat? = nil,
        lineHeight: CGFloat? = nil,
        isUnderlined: Bool = false
    ) -> NSAttributedString {
        let font = UIFont.sfPro(style)
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font
        ]
        
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
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}
