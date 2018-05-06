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
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "chattrBox")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let devNameLabel: UILabel = {
        let label = UILabel()
        guard let customFont = UIFont(name: "Glitzstick", size: 40) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        label.font = UIFontMetrics.default.scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(red: 21/255, green: 124/255, blue: 246/255, alpha: 1)
        label.text = "by: CeriOSly"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        animateViews()
        if isRunning == false {
            guard timer == nil else {return}
            timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(segueToTabBar), userInfo: nil, repeats: false)
            isRunning = true
        }
    }
    
    func setupViews() {
    
        view.addSubview(logoImageView)
        view.addSubview(devNameLabel)
        logoImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        devNameLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
        devNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        devNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        devNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    fileprivate func animateViews() {
        UIView.animate(withDuration: 1.0, delay: 3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.logoImageView.transform = CGAffineTransform(translationX: 0, y: -250)
            self.logoImageView.alpha = 0
            self.devNameLabel.transform = CGAffineTransform(translationX: 0, y: 250)
            self.devNameLabel.alpha = 0
        }) { (_) in
            
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
