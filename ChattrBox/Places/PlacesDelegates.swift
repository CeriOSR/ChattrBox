//
//  PlacesDelegates.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-03.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation
import UIKit

extension PlacesCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if places != nil {
            return (places?.count)!
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PlacesCollectionViewCell
        
        if let sortedPlaces = places?.sorted(byKeyPath: "name") {
            let place = sortedPlaces[indexPath.item]
            cell.placesNameLbl.text = place.name
            if let imageFileName = place.imageFileName {
                cell.placesCellImageView.loadImageFromFileNameString(fileName: imageFileName)
            } else {
                cell.placesCellImageView.image = #imageLiteral(resourceName: "NoImage")
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
        if let sortedPlaces = places?.sorted(byKeyPath: "name") {
            let place = sortedPlaces[indexPath.item]
            guard let name = place.name else {return}
            audioModels.playTextToSpeech(name)
//            if let audioFileName = place.audioFileName {
//                audioModels.setupPlayer(fileName: audioFileName)
//                audioModels.audioPlayer.play()
//            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButtonItem.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                let cell = collectionView?.cellForItem(at: indexPath) as! PlacesCollectionViewCell
                cell.isEditing = editing
            }
        }
    }
}

extension PlacesCollectionViewController: PlacesCellDelegate {
    func deleteCell(_ cell: PlacesCollectionViewCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            if let sortedPlaces = places?.sorted(byKeyPath: "name") {
                let item = sortedPlaces[indexPath.item]
                chattrRealm.deleteItems(item, controllerId: controllerId)
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
}
