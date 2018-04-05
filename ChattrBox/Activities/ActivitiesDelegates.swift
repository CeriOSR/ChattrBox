//
//  ActivitiesDelegates.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-03.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation
import UIKit

extension ActivitiesCollectionViewController {
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
        cell.delegate = self
        if let sortedActivities = activities?.sorted(byKeyPath: "name") {
            let activity = sortedActivities[indexPath.item]
            cell.activitiesLbl.text = activity.name
            if let imageFileName = activity.imageFileName {
                cell.activitiesCellImageView.loadImageFromFileNameString(fileName: imageFileName)
            } else {
                cell.activitiesCellImageView.image = #imageLiteral(resourceName: "NoImage")
            }
        }
        cell.deleteButtonBGView.layer.cornerRadius = cell.deleteButtonBGView.bounds.width / 2
        cell.deleteButtonBGView.layer.masksToBounds = true
        cell.deleteButtonBGView.isHidden = !cell.isEditing
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 140.0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let sortedActivities = activities?.sorted(byKeyPath: "name") {
            let activity = sortedActivities[indexPath.item]
            if let audioFileName = activity.audioFileName {
                audioModels.setupPlayer(fileName: audioFileName)
                audioModels.audioPlayer.play()
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButtonItem.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                let cell = collectionView?.cellForItem(at: indexPath) as! ActivitiesCollectionViewCell
                cell.isEditing = editing
            }
        }
    }
}

extension ActivitiesCollectionViewController: ActivityCellDelegate {
    func deleteCell(_ cell: ActivitiesCollectionViewCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            if let sortedActivities = activities?.sorted(byKeyPath: "name") {
                let item = sortedActivities[indexPath.item]
                chattrRealm.deleteItems(item)
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
}

