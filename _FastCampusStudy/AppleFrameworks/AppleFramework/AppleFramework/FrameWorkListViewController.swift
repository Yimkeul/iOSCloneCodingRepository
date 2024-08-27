//
//  FrameWorkListViewController.swift
//  AppleFramework
//
//  Created by yimkeul on 8/22/24.
//

import UIKit

class FrameWorkListViewController: UIViewController {

    @IBOutlet weak var FrameWorkCollectionView: UICollectionView!
    let frameWorks: [AppleFramework] = AppleFramework.list

    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    typealias Item = AppleFramework


    enum Section {
        case main
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        FrameWorkCollectionView.dataSource = self
        FrameWorkCollectionView.delegate = self

        // MARK: Diffable datasource 사용
        // - presentation
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: FrameWorkCollectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameWorkListCollectionViewCell", for: indexPath) as? FrameWorkListCollectionViewCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        // snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(frameWorks, toSection: .main)
        datasource.apply(snapshot)

        // compositional Layout
        // - layout
        FrameWorkCollectionView.collectionViewLayout = layout()

//        if let flowlayout = FrameWorkCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowlayout.estimatedItemSize = .zero
//        }
//        FrameWorkCollectionView.contentInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)

    }

    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(0.33))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        if #available(iOS 16.0, *) {
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        } else {
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }
    }


}

//extension FrameWorkListViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return frameWorks.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = FrameWorkCollectionView.dequeueReusableCell(withReuseIdentifier: "FrameWorkListCollectionViewCell", for: indexPath) as? FrameWorkListCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        let framework = frameWorks[indexPath.item]
//        cell.configure(framework)
//        return cell
//
//    }
//}
//
//extension FrameWorkListViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let interItemSpacing: CGFloat = 10
//        let padding: CGFloat = 16
//        let width = (collectionView.bounds.width - interItemSpacing * 2 - padding * 2) / 3
//        let height = width * 1.5
//        return CGSize(width: width, height: height)
//    }
//
//    // 줄간 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//}

extension FrameWorkListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("click \(frameWorks[indexPath.item].name)")
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FrameworkDetailViewController") as! FrameworkDetailViewController
        vc.framework = frameWorks[indexPath.item]
//        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
//        navigationController?.pushViewController(vc, animated: true)

    }
}
