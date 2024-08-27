//
//  QuickFocusCell.swift
//  HeadSpaceFocus
//
//  Created by yimkeul on 8/26/24.
//

import UIKit

class QuickFocusCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(_ quickFoucs: QuickFocus) {
        thumbnailImageView.image = UIImage(named: quickFoucs.imageName)
        titleLabel.text = quickFoucs.title
        descriptionLabel.text = quickFoucs.description
    }
    
}
