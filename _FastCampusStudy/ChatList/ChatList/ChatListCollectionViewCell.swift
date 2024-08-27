//
//  ChatListCollectionViewCell.swift
//  ChatList
//
//  Created by yimkeul on 8/21/24.
//

import UIKit

class ChatListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var chatListImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        chatListImageView.layer.cornerRadius = 10
    }
    
    func configure(_ chat: Chat) {

        chatListImageView.image = UIImage(named: chat.name)
//        chatListImageView.layer.cornerRadius = 16
//        chatListImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = chat.name
        chatLabel.text = chat.chat
        chatLabel.numberOfLines = 2
        let date = formattedDateString(dateString: chat.date)
        dateLabel.text = date

    }
    
    

    func formattedDateString(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "M/d"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }


}
