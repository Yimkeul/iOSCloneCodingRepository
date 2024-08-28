//
//  ViewController.swift
//  InfinityBannerTutorial
//
//  Created by yimkeul on 8/28/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerIndexLabel: UILabel!

    var db: [String] = ["Image1", "Image2", "Image3"]
    var bannerIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        setupLabel()
    }


}

extension ViewController {
    func setupCollectionView() {
        let nib = UINib(nibName: BannerCollectionViewCell.identifier, bundle: nil)
        bannerCollectionView.register(nib, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.showsHorizontalScrollIndicator = false
        let layout = createLayout()
        bannerCollectionView.collectionViewLayout = layout
    }

    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.collectionView?.isPagingEnabled = true
        layout.itemSize = CGSize(width: bannerCollectionView.frame.width, height: 150)
        return layout
    }

    func setupLabel() {
        bannerIndexLabel.layer.cornerRadius = 10
        bannerIndexLabel.clipsToBounds = true
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return db.count * 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(db[indexPath.item])
        return cell
    }


}


extension ViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard db.count > 2 else {
            bannerIndex = 0
            return
        }
        let currnetIndex = Int(scrollView.contentOffset.x / bannerCollectionView.frame.width)
        bannerIndex = currnetIndex
        self.bannerIndexLabel.text = "\(bannerIndex)/\(db.count)"
        var visibleIndex = 0
        if bannerIndex == 0 {
            visibleIndex = db.count
        } else if bannerIndex == db.count - 1 {
            visibleIndex = 1
        } else {
            visibleIndex = bannerIndex
        }
        
//        var item = db.i
        
        bannerCollectionView.scrollToItem(at: IndexPath(row: visibleIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
}

