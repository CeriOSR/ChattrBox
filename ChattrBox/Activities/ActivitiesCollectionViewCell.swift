//
//  ActivitiesCollectionViewCell.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class ActivitiesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var deleteButtonBGView: UIVisualEffectView!
    @IBOutlet weak var activitiesLbl: UILabel!
    @IBOutlet weak var activitiesCellImageView: UIImageView!
    weak var delegate : ActivityCellDelegate?
    var isEditing: Bool = false {
        didSet{
            deleteButtonBGView.isHidden = !isEditing
        }
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.deleteCell(self)
    }
}

protocol ActivityCellDelegate: class {
    func deleteCell(_ cell: ActivitiesCollectionViewCell)
}
