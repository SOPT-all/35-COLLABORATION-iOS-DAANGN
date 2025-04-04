//
//  UIView+.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/17/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
    func makeShadow(radius : CGFloat, offset : CGSize, opacity : Float){
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func makeCornerRound(radius : CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func makeBorder(width : CGFloat ,color : UIColor ) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    /// 특정 corner에만 radius값을 적용하는 함수입니다.
    func roundCorners(radius: CGFloat, to corners: CACornerMask) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        layer.masksToBounds = true
    }
}
