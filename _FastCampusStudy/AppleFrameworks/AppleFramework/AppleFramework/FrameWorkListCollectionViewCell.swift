//
//  FrameWorkListCollectionViewCell.swift
//  AppleFramework
//
//  Created by yimkeul on 8/22/24.
//

import UIKit

class FrameWorkListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(_ framework: AppleFramework) {
        thumbnailImageView.image = UIImage(named: framework.imageName)
        nameLabel.text = framework.name
    }
    
    
    
}
