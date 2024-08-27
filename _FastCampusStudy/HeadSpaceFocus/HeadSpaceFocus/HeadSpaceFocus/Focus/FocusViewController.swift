//
//  FocusViewController.swift
//  HeadSpaceFocus
//
//  Created by yimkeul on 8/26/24.
//

import UIKit

class FocusViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var refreshButton: UIButton!
    
    var items: [Focus] = Focus.list
    
    var curated: Bool = false

    typealias Item = Focus
    enum Section {
        case main
    }
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButton.layer.cornerRadius = 10
        // Presentaion
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FocusCell", for: indexPath) as? FocusCell else {
                return nil
            }
            cell.configure(itemIdentifier)
            return cell
        })
        // Data(SnapShot)
        snapshot()
        updateButtonTitle()
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        curated.toggle()
        self.items = curated ? Focus.recommendations : Focus.list
        snapshot()
    }
    
    private func updateButtonTitle() {
        let title = curated ? "See All" : "See Recommendation"
        refreshButton.setTitle(title, for: .normal)
    }
    private func snapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        datasource.apply(snapshot)
        updateButtonTitle()
    }
}


extension FocusViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        let storyboard = UIStoryboard(name: "QuickFocus", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuickFocusListViewController") as! QuickFocusListViewController
        vc.title = item.title
        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }
}
