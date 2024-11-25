//
//  FooterScrollDelegate.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/25/24.
//

protocol FooterScrollDelegate: AnyObject {
    func didScrollTo(page: Int)
}

protocol FooterConnectDelegate: AnyObject {
    func connect(page: Int)
}
