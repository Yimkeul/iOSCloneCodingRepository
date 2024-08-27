//
//  HomeViewController.swift
//  InstaSearchView
//
//  Created by yimkeul on 8/22/24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var homeCollectionView: UICollectionView!
    var isTabBarHidden: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        if let flowlayout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = .zero
        }
        
    }

}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageName = "animal\(indexPath.item + 1)"
        cell.configure(imageName)
        return cell
    }


}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("스크롤 값: \(velocity.y), tabBar 상태: \(isTabBarHidden)")
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            // 스크롤이 위로 발생했거나, 현재 탭바가 숨겨져 있는 상태에서 약간의 스크롤이 발생한 경우
            if velocity.y < 0 || (velocity.y == 0 && self.isTabBarHidden) {
                let height = self.tabBarController?.tabBar.frame.height ?? 0.0
                self.tabBarController?.tabBar.alpha = 1.0
                self.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - height)
                self.isTabBarHidden = false
            } else if velocity.y > 0 || (velocity.y == 0 && !self.isTabBarHidden) {
                // 스크롤이 아래로 발생했거나, 현재 탭바가 보이는 상태에서 약간의 스크롤이 발생한 경우
                self.tabBarController?.tabBar.alpha = 0.0
                self.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
                self.isTabBarHidden = true
            }
        }
    }



}
