//
//  URL.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-01.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation

extension URL {
    var typeIdentifier: String? {
        return try! resourceValues(forKeys: [.typeIdentifierKey]).typeIdentifier
    }
    
    var localizedName: String? {
        return try! resourceValues(forKeys: [.localizedNameKey]).localizedName
    }
}

extension String {
    func stringByAppendingPathComponent(path: String) -> String {
        let nsString = self as NSString
        return nsString.appendingPathComponent(path)
    }
}

