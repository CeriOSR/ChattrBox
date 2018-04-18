//
//  AacEssentialsCollectionViewCell.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-17.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class AACEssentialsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deleteBGViewItem: UIVisualEffectView!
    @IBOutlet weak var aCCImageView: UIImageView!
    @IBOutlet weak var aCCNameLbl: UILabel!
    var delegate : AACEssentialsCellDelegate?
    var isEditing: Bool = false {
        didSet{
            deleteBGViewItem.isHidden = !isEditing
        }
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.deleteCell(self)
    }
}

protocol AACEssentialsCellDelegate {
    func deleteCell(_ cell: AACEssentialsCollectionViewCell)
}
