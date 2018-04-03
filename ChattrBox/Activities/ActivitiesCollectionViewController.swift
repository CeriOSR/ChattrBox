//
//  ActivitiesCollectionViewController.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "activitiesCellId"

class ActivitiesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let realm = try! Realm()
    var activities : Results<Items>?
//    Results<Items>
//    {
//        get{
//                return realm.objects(Items.self).filter("type == 'Activites'")
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .red
        fetchAndFilter()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controllerId = "Activities"
        let destViewController: AddItemViewController = segue.destination as! AddItemViewController
        destViewController.fromId = controllerId
    }
  
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if activities != nil {
            return (activities?.count)!
        } else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ActivitiesCollectionViewCell
        let sortedActivities = activities?.sorted(byKeyPath: "name")
        let activity = sortedActivities![indexPath.item]
        print(activities?.count ?? "")
        if let imageUrl = activity.imageUrl {
            cell.activitiesCellImageView.loadEventImageUsingCacheWithUrlString(urlString: imageUrl)
        } else {
            cell.activitiesCellImageView.image = #imageLiteral(resourceName: "pictureThis")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    private func fetchAndFilter() {
        let items = realm.objects(Items.self)
        let filteredItems = items.filter("type = 'Activities'")
        let sortedItems = filteredItems.sorted(byKeyPath: "name")
        activities = sortedItems
    }
    
    @IBAction func activitiesAddButton(_ sender: Any) {
    }
    
    
    
}
