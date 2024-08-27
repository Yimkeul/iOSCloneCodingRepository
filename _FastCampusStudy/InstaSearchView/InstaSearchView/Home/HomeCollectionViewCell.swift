//
//  HomeCollectionViewCell.swift
//  InstaSearchView
//
//  Created by yimkeul on 8/22/24.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var animalImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        animalImageView.image = nil
    }
    
    func configure(_ imageName: String) {
        nameLabel.text = "National Geographic"
        animalImageView.image = UIImage(named: imageName)
    }
}
