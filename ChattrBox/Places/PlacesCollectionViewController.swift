//
//  PlacesCollectionViewController.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import RealmSwift


class PlacesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let audioModels = AudioModels()
    let reuseIdentifier = "placesCellId"
    let chattrRealm = ChattrRealm()
    var places : Results<Items>?
    let controllerId = "Places"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .blue
        places = chattrRealm.fetchAndFilter(controllerId)
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
    
    @IBAction func placesAddButton(_ sender: Any) {
        self.performSegue(withIdentifier: "placesToAddItem", sender: self)
    }
}
