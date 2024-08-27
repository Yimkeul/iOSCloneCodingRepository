//
//  ResultCellCollectionViewCell.swift
//  InstaSearchView
//
//  Created by yimkeul on 8/22/24.
//

import UIKit

class ResultCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!

    
    // 재사용 되기 전 준비하는 함수
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil // reset
    }
    
    func configure(_ imageName: String) {
        thumbnailImageView.image = UIImage(named: imageName)
    }
}
