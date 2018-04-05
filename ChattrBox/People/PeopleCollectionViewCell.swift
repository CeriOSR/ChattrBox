//
//  PeopleCollectionViewCell.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var peopleCellImageView: UIImageView!
    @IBOutlet weak var deleteButtonBGView: UIVisualEffectView!
    weak var delegate : PeopleCellDelegate?
    var isEditing: Bool = false {
        didSet{
            deleteButtonBGView.isHidden = !isEditing
        }
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.deleteCell(self)
    }
}

protocol PeopleCellDelegate: class {
    func deleteCell(_ cell: PeopleCollectionViewCell)
}
