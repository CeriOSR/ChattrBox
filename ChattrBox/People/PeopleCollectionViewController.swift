//
//  PeopleCollectionViewController.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import RealmSwift


class PeopleCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let audioModels = AudioModels()
    let reuseIdentifier = "peopleCellId"
    let chattrRealm = ChattrRealm()
    var people : Results<Items>?
    let controllerId = "People"
    @IBOutlet weak var addButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .green
        navigationItem.leftBarButtonItem = editButtonItem
        people = chattrRealm.fetchAndFilter(controllerId)

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

    @IBAction func peopleAddButton(_ sender: Any) {
    }
}
