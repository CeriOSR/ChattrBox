//
//  ActivitiesCollectionViewController.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation

class ActivitiesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, AVAudioPlayerDelegate {
    
    let audioModels = AudioModels()
    let reuseIdentifier = "activitiesCellId"
    let chattrRealm = ChattrRealm()
    var activities : Results<Items>?
    let controllerId = "Activities"
    @IBOutlet weak var addButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        activities = chattrRealm.fetchAndFilter(controllerId)
        navigationItem.leftBarButtonItem = editButtonItem
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
    
    @IBAction func activitiesAddButton(_ sender: Any) {
    }
    
}

