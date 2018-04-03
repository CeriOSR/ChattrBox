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
    
    func loadEventImageUsingCacheWithUrlString(urlString: String) {
        self.image = nil
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        } else {
            
            
            guard let url = URL(string: urlString) else {return}
//                        let url = NSURL(string: urlString)
                        URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, response, error) in
                            if error != nil {
                                let err = error! as NSError
                                print(err)
                                return
                            }
                            DispatchQueue.main.async {
                                if let downloadedImage = UIImage(data: data!) {
                                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                                    self.image = downloadedImage
                                }
                            }
                        }).resume()
//            Alamofire.request(url).response(completionHandler: { (response) in
//                if response.error != nil {
//                    print(response.error ?? "No Image Found")
//                } else {
//                    guard let data = response.data else {return}
//                    if let image = UIImage(data: data) {
//                        imageCache.setObject(image, forKey: urlString as AnyObject)
//                        self.image = image
//                    }
//
//                }
//            })
            
        }
    }
}
