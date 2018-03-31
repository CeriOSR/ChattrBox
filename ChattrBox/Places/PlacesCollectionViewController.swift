//
//  PlacesCollectionViewController.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "placesCellId"

class PlacesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let controllerId = "Places"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .blue
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PlacesCollectionViewCell
    
        cell.placesCellImageView.image = #imageLiteral(resourceName: "pictureThis").withRenderingMode(.alwaysOriginal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    @IBAction func placesAddButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "placesToAddItem", sender: self)
    }
}
