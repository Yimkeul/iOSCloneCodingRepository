//
//  BannerCollectionViewCell.swift
//  InfinityBannerTutorial
//
//  Created by yimkeul on 8/28/24.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var banner: UIImageView!
    static let identifier = String(describing: BannerCollectionViewCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(_ image: String) {
        banner.image = UIImage(named: image)
    }
}
