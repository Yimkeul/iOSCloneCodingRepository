//
//  StockRankViewController.swift
//  StockRank
//
//  Created by yimkeul on 8/21/24.
//

import UIKit
import SwiftUI



class StockRankViewController: UIViewController {

    
    let stockList: [StockModel] = StockModel.list

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        MARK: UICollectionView를 사용하기 위해선 알아야 할것
//        - Data : 어떤 데이터? ==> stockList
//        - Presentation : 셀을 어떻게 표현? => UICollectionViewDataSource
//        - Layout : 셀을 어떻게 배치? => UICollectionViewDelegateFlowLayout

        collectionView.dataSource = self
        collectionView.delegate = self


    }
}

extension StockRankViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stockList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCollectionViewCell", for: indexPath) as? StockRankCollectionViewCell else {
            return UICollectionViewCell()
        }
        let stock = stockList[indexPath.item]
        cell.configure(stock)
        return cell
    }
}

extension StockRankViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80)
    }

    
}


struct PreView: PreviewProvider {
    static var previews: some View {
        // Preview를 보고자 하는 ViewController를 넣으면 됩니다.
        StockRankViewController().toPreview()
    }
}
