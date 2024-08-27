//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by yimkeul on 8/26/24.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
