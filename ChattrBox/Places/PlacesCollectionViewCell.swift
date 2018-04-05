//
//  PlacesCollectionViewCell.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class PlacesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var placesCellImageView: UIImageView!
    @IBOutlet weak var deleteButtonBGView: UIVisualEffectView!
    weak var delegate : PlacesCellDelegate?
    var isEditing: Bool = false {
        didSet{
            deleteButtonBGView.isHidden = !isEditing
        }
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.deleteCell(self)
    }
}

protocol PlacesCellDelegate: class {
    func deleteCell(_ cell: PlacesCollectionViewCell)
}
