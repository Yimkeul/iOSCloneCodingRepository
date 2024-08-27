//
//  BannerCell.swift
//  SpotifyPaywall
//
//  Created by joonwon lee on 2022/04/30.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImaveView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 16
    }
    
    func configure(_ item: BannerInfo) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        thumbnailImaveView.image = UIImage(named: item.imageName)
    }
    
    
}
