//
//  OnboardingViewController.swift
//  NRCOnboarding
//
//  Created by yimkeul on 8/23/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    let messages: [OnboardingMessage] = OnboardingMessage.messages
    var tempIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }

        pageControl.numberOfPages = messages.count
        pageControl.currentPage = 0

    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        let message = messages[indexPath.item]
        cell.configure(message)
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var index = Int(scrollView.contentOffset.x / self.collectionView.bounds.width)

        if tempIndex >= messages.count {
            index = 0
            // 스크롤을 처음으로 이동
            let indexPath = IndexPath(item: 0, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }

        tempIndex = index
        pageControl.currentPage = index
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / self.collectionView.bounds.width
        let cnt = messages.count - 1
        if pageIndex > CGFloat(Double(cnt) * 1.1) {
            tempIndex += 1
        }
        
    }

}


