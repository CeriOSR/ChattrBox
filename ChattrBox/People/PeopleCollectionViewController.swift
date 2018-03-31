//
//  PeopleCollectionViewController.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "peopleCellId"

class PeopleCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        collectionView?.backgroundColor = .green
//        self.navigationItem.hidesBackButton = true

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controllerId = "People"
        let destViewController: AddItemViewController = segue.destination as! AddItemViewController
        destViewController.fromId = controllerId
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PeopleCollectionViewCell
    
        cell.peopleCellImageView.image = #imageLiteral(resourceName: "pictureThis").withRenderingMode(.alwaysOriginal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }

    @IBAction func peopleAddButton(_ sender: Any) {
    }
    
}
