//
//  AlertsModels.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-09.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation
import UIKit

class AlertsModels: UIAlertController {
    
    func createAlertWithOneAction(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: {
                //maybe do something here
            })
        }
        alert.addAction(okAction)
        self.present(alert, animated: true) {
            //maybe do something here.
        }
    }
    
    func createAlertWithTwoActions(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
//            self.dismiss(animated: true, completion: {
                //maybe do something here
//            })
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
//            self.dismiss(animated: true, completion: {
                //maybe do something here
//            })
        }
        alert.addAction(okAction)
        alert.addAction(cancel)
        self.present(alert, animated: true) {
            //maybe do something here.
        }
    }
    
    
}
