//
//  UIImageExtensions.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-02.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation
import UIKit

private let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func loadImageFromFileNameString(fileName: String) {
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            self.image = UIImage(data: imageData)
        } catch {
            let alert = UIAlertController(title: "Image Not Found", message: "Try deleting the image and adding it again.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (action) in

            }
            alert.addAction(action)
            UIApplication.topViewController()?.present(alert, animated: true, completion: {
                
            })
        }
        
    }
}
