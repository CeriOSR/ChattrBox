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

class GetFileUrl {
    let alertModels = AlertsModels()
    private func getCacheDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let first = paths.first else {return "no path"}
        return first
    }

    func makePermanentCopy(_ fileName: String) {
        do {
            try FileManager.default.copyItem(at: getFileUrl(), to: getPermanentFileUrl(fileName))
        } catch {
            alertModels.createAlertWithOneAction("Save Unsuccessful", message: "Make sure you have enough storage space.")
        }
    }
    
    func getFileName(_ name: String) -> String {
        let fileName = NSUUID().uuidString + "-\(name)" + ".m4a"
        return fileName
    }
    
    func getPermanentFileUrl(_ nameString: String) -> URL {
        let name = nameString
        let fileName = getFileName(name)
        let path  = getCacheDirectory().stringByAppendingPathComponent(path: fileName)
        let fileUrl = URL(fileURLWithPath: path)
        return fileUrl
    }

    func getFileUrl() -> URL {
        let fileName = "soundBite.m4a"
        let path = getCacheDirectory().stringByAppendingPathComponent(path: fileName)
        let fileUrl = URL(fileURLWithPath: path)
        return fileUrl
    }
}

