//
//  InfinityTest.swift
//  InfinityBannerTutorial
//
//  Created by yimkeul on 8/28/24.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

struct PreView: PreviewProvider {
    static var previews: some View {
        // Preview를 보고자 하는 ViewController를 넣으면 됩니다.
        TestViewController().toPreview()
    }
}

class TestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var originalItems: [MockModel] = [
        .init(num: 1, color: .red),
        .init(num: 2, color: .orange),
        .init(num: 3, color: .yellow)
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfinityCarouselContainerCell.id, for: indexPath) as! InfinityCarouselContainerCell
        
        cell.configure(originalItems)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: UIScreen.main.bounds.width, height: 124)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(InfinityCarouselContainerCell.self, forCellWithReuseIdentifier: InfinityCarouselContainerCell.id)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
}

/// InfinityCarouselCell 셀
final class InfinityCarouselContainerCell: UICollectionViewCell {
    static let id: String = String(describing: InfinityCarouselContainerCell.self)
    
    func configure(_ originalItems: [MockModel]) {
        collectionView.configure(originalItems)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionView = InfinityCarouselCollectionView()
}

struct MockModel: Hashable {
    var id = UUID()
    
    var num: Int
    var color: UIColor
}

final class InfinityCarouselCollectionView: UICollectionView {
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, MockModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MockModel>

    /// 섹션
    enum Section {
        case main
    }

    /// 디퍼블 데이터 소스
    private var diffableDataSource: DiffableDataSource?
    /// 오리지널 아이템
    private var originalItems: [MockModel] = []

    func configure(_ originalItems: [MockModel]) {
        self.originalItems = originalItems
        
        // ✅ 아래 두 함수 호출 순서에 주의
        configureDiffableDataSource()
        updateSnapshot()
    }
    
    /// 컬렉션 뷰에 들어가는 데이터소스를 구성
    private func configureDiffableDataSource() {
        diffableDataSource = .init(collectionView: self) { collectionView, indexPath, itemIdentifier -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCell.id,
                for: indexPath
            ) as? BannerCell else { return UICollectionViewCell() }
            
            // ✅ 앞뒤로 3배 했으므로 이렇게 적용.
            let item = self.originalItems[indexPath.row % 3]
            cell.configure(item, indexPath)
            
            return cell
        }
    }
    
    /// 스냅샷 업데이트
    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        
        // ✅ 확장된 아이템에 배열을 넣고
        var extendedItems = originalItems
        
        for i in 0..<(originalItems.count * 2) {
            let item = originalItems[i % 3]
            // ✅ diffable의 특성상 id가 겹치면 안되므로 새로운 객체를 생성해서 넣어줌.
            // ✅ 모델이 큰 경우에는 id값만 바꾸는 전략 이용.
            extendedItems.append(MockModel(num: item.num, color: item.color))
        }
        
        snapshot.appendItems(extendedItems)
        
        self.diffableDataSource?.apply(snapshot, animatingDifferences: true) { [weak self] in
            guard let self else { return }
            
            // ✅ 처음에 collectionView가 나타날 때, 할 때 좌측에 아이템이 한개 이상은 있어야 하므로 스크롤 수행
            self.scrollToItem(at: [0, self.originalItems.count],
                              at: .left,
                              animated: false)
            // 컬렉션 뷰가 그려지고 난 후에 불림.
        }
    }
    
    /// ✅ 무한 스크롤을 위해 visibleItemsInvalidationHandler에서 indexPath를 조정
    private func handleVisibleItemIndexPath(_ indexPath: IndexPath) {
        switch indexPath.row {
            case self.originalItems.count - 1:
            self.scrollToItem(at: [0, self.originalItems.count * 2 - 1], at: .left, animated: false)
            case self.originalItems.count * 2 + 1:
            self.scrollToItem(at: [0, self.originalItems.count], at: .left, animated: false)
            default:
            break
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: .init())
        self.collectionViewLayout = createLayout()
        self.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 레이아웃
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                                                             heightDimension: .fractionalHeight(1.0)),
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.contentInsets = .init(top: 12, leading: 0, bottom: 12, trailing: 0)
            
            section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, offset, environment) in
                // ✅ UIScrollViewDelegate의 didScroll가 아닌 해당 영역에서 처리해야 함.
                guard let self else { return }
                
                // visibleItems 중 가장 마지막 indexPath를 찾아서 미리 스크롤 해둬야 애니메이션 끊기는 문제 없음.
                guard let lastIndexPath = visibleItems.last?.indexPath else { return }
                self.handleVisibleItemIndexPath(lastIndexPath)
            }
            
            return section
        }
    }
    
    final class BannerCell: UICollectionViewCell {
        static let id: String = String(describing: BannerCell.self)
        
        func configure(_ model: MockModel, _ indexPath: IndexPath) {
            contentView.backgroundColor = model.color
            contentView.layer.cornerRadius = 16
            titleLabel.text = """
            아이템의 숫자 \(model.num)
            인덱스 패스 \(indexPath)
            """
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            configureUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private lazy var titleLabel: UILabel = {
            var lb = UILabel()
            lb.textAlignment = .center
            lb.numberOfLines = 2
            lb.font = .systemFont(ofSize: 22, weight: .medium)
            return lb
        }()
        
        private func configureUI() {
            contentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
}
