//
//  ClassNameProtocol.swift
//  Daangn_iOS
//
//  Created by 최유빈 on 11/21/24.
//

import UIKit

// MARK: - Protocol

protocol ClassNameProtocol {
    
    static var className: String { get }
}

// MARK: - Extension

extension ClassNameProtocol {
    
    static var className: String {
        return String(describing: self)
    }
}
