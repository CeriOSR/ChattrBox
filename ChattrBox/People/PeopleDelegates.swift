//
//  PeopleDelegates.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-03.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation
import UIKit

extension PeopleCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if people != nil {
            return (people?.count)!
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PeopleCollectionViewCell
        cell.delegate = self
        if let sortedPeople = people?.sorted(byKeyPath: "name") {
            let person = sortedPeople[indexPath.item]
            cell.peopleNameLbl.text = person.name
            if let imageFileName = person.imageFileName {
                cell.peopleCellImageView.loadImageFromFileNameString(fileName: imageFileName)
            } else {
                cell.peopleCellImageView.image = #imageLiteral(resourceName: "NoImage")
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
        if let sortedPeople = people?.sorted(byKeyPath: "name") {
            let person = sortedPeople[indexPath.item]
            guard let name = person.name else {return}
            audioModels.playTextToSpeed(name)
//            if let audioFileName = person.audioFileName {
//                audioModels.setupPlayer(fileName: audioFileName)
//                
//                audioModels.audioPlayer.play()
//            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButtonItem.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                let cell = collectionView?.cellForItem(at: indexPath) as! PeopleCollectionViewCell
                cell.isEditing = editing
            }
        }
    }
}

extension PeopleCollectionViewController: PeopleCellDelegate {
    func deleteCell(_ cell: PeopleCollectionViewCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            if let sortedPeople = people?.sorted(byKeyPath: "name") {
                let item = sortedPeople[indexPath.item]
                chattrRealm.deleteItems(item)
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
}
