//
//  ChatListViewController.swift
//  ChatList
//
//  Created by yimkeul on 8/21/24.
//

import UIKit

class ChatListViewController: UIViewController {



    @IBOutlet weak var chatListCollectionView: UICollectionView!
    var chatList: [Chat] = Chat.list

    override func viewDidLoad() {
        super.viewDidLoad()

        chatListCollectionView.dataSource = self
        chatListCollectionView.delegate = self
        chatList.sort  { $0.date > $1.date }
    }


}

extension ChatListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatListCollectionViewCell", for: indexPath) as? ChatListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let chat = chatList[indexPath.item]
        cell.configure(chat)
        return cell
    }
}

extension ChatListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }

}
