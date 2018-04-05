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
        
        if let sortedPeople = people?.sorted(byKeyPath: "name") {
            let person = sortedPeople[indexPath.item]
            if let imageFileName = person.imageFileName {
                cell.peopleCellImageView.loadImageFromFileNameString(fileName: imageFileName)
            } else {
                cell.peopleCellImageView.image = #imageLiteral(resourceName: "NoImage")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let sortedPeople = people?.sorted(byKeyPath: "name") {
            let person = sortedPeople[indexPath.item]
            if let audioFileName = person.audioFileName {
                audioModels.setupPlayer(fileName: audioFileName)
                
                audioModels.audioPlayer.play()
            }
        }
    }
}
