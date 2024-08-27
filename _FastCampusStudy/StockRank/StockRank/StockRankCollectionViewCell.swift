//
//  StockRankCollectionViewCell.swift
//  StockRank
//
//  Created by yimkeul on 8/21/24.
//

import UIKit

class StockRankCollectionViewCell: UICollectionViewCell {
    // TODO: uicomponent 연결
    // TODO: uicomponent에 데이터를 업데이트하는 코드 넣기


    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var companyIconImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyPriceLabel: UILabel!
    @IBOutlet weak var diffLabel: UILabel!


    func configure(_ stoke: StockModel) {
        rankLabel.text = "\(stoke.rank)"
        companyIconImageView.image = UIImage(named: stoke.imageName)
        companyNameLabel.text = stoke.name
        let price = convert2CurrencyFormat(price: stoke.price)
        companyPriceLabel.text = "\(price)원"
        diffLabel.text = "\(stoke.diff)%"
        configureDiffLabel(stoke.diff)
    }
    
    func convert2CurrencyFormat(price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        // from은 파라미터가 NSNumber , for 는 Any 타입
//        _ =  numberFormatter.string(from: NSNumber(value: price)) ?? ""
//        _ = numberFormatter.string(for: price) ?? ""
        
        return numberFormatter.string(for: price) ?? ""
    }
    
    func configureDiffLabel(_ diff: Double) {
        if diff > 0 {
            diffLabel.textColor = UIColor.red
        } else if diff == 0.0 {
            diffLabel.textColor = UIColor.lightGray
        } else {
            diffLabel.textColor = UIColor.blue
        }
    }




}
