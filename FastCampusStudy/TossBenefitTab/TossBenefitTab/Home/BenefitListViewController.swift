//
//  BenefitListViewController.swift
//  TossBenefitTab
//
//  Created by yimkeul on 8/29/24.
//

import UIKit
import Combine

class BenefitListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    typealias Item = AnyHashable

    enum Section: Int {
        case today
        case other
    }

    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
//    var todaySectionItems: [AnyHashable] = TodaySectionItem(point: .default, today: .today).sectionItems // 포인트, 오늘의 혜택
//    var otherSectionItems: [AnyHashable] = Benefit.others // 혜택, 나머지 리스트


    var subscriptions = Set<AnyCancellable>()

    let viewModel = BenefitListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupUI()
        bind()
        viewModel.fetchItems()
    }

    private func configureCollectionView() {
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in

            guard let section = Section(rawValue: indexPath.section) else { return nil }

            let cell = self.configureCell(for: section, item: itemIdentifier, collectionView: collectionView, indexPath: indexPath)

            return cell
        })

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.today, .other])
        snapshot.appendItems([], toSection: .today)
        snapshot.appendItems([], toSection: .other)
        datasource.apply(snapshot)

        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
    }


    private func setupUI() {
        navigationItem.title = "혜택"
    }

    private func bind() {
        viewModel.$todaySectionItems
            .receive(on: RunLoop.main)
            .sink {
            self.applySnapshot(items: $0, section: .today)
        }
            .store(in: &subscriptions)

        viewModel.$otherSectionItems.receive(on: RunLoop.main)
            .sink {
            self.applySnapshot(items: $0, section: .other)
        }
            .store(in: &subscriptions)


        viewModel.benefitDidTapped
            .receive(on: RunLoop.main)
            .sink { benefit in
                let sb = UIStoryboard(name: "ButtonBenefit", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "ButtonBenefitViewController") as! ButtonBenefitViewController
//                vc.viewModel.benefit = benefit
                vc.viewModel = ButtonBenefitViewModel(benefit: benefit)
                self.navigationController?.pushViewController(vc, animated: true)
        }
            .store(in: &subscriptions)
        
        viewModel.pointDidTapped
            .receive(on: RunLoop.main)
            .sink { point in
                let sb = UIStoryboard(name: "Mypoint", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MyPointViewController") as! MyPointViewController
                vc.viewModel = MypointViewModel(point: point)
//                vc.viewModel.point = point
                self.navigationController?.pushViewController(vc, animated: true)
        }
            .store(in: &subscriptions)
    }

    private func applySnapshot(items: [Item], section: Section) {
        var snapshot = datasource.snapshot()
        snapshot.appendItems(items, toSection: section)
        datasource.apply(snapshot)
    }

    private func layout() -> UICollectionViewCompositionalLayout {

        let spacing: CGFloat = 10

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = spacing



        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

    private func configureCell(for section: Section, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        switch section {
        case .today:
            if let point = item as? MyPoint {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPointCell", for: indexPath) as! MyPointCell
                cell.configure(item: point)
                return cell
            } else if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayBenefitCell", for: indexPath) as! TodayBenefitCell
                cell.configure(item: benefit)
                return cell
            } else {
                return nil
            }
        case .other:
            if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
                cell.configure(item: benefit)
                return cell
            } else {
                return nil
            }
        }
    }

}

extension BenefitListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = datasource.itemIdentifier(for: indexPath)
        print("\(String(describing: item))")

        if let benefit = item as? Benefit {
            viewModel.benefitDidTapped.send(benefit)
        } else if let point = item as? MyPoint {
            viewModel.pointDidTapped.send(point)
        } else {
        }
    }
}
