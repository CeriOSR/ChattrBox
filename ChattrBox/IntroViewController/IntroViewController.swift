//
//  IntroViewController.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-05.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    var timer : Timer?
    var isRunning: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        if isRunning == false {
            timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(segueToTabBar), userInfo: nil, repeats: false)
            isRunning = true
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    @objc func segueToTabBar() {
        performSegue(withIdentifier: "introToTabBar", sender: self)

    }
    
}
