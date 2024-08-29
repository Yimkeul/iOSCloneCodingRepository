//
//  TodaySectionItem.swift
//  TossBenefitTab
//
//  Created by yimkeul on 8/29/24.
//

import Foundation

struct TodaySectionItem {
    var point: MyPoint
    var today: Benefit
    
    var sectionItems: [AnyHashable] {
        return [point, today]
    }
}

extension TodayBenefitCell {
    static let mock = TodaySectionItem(point: MyPoint(point: 0), today: Benefit.walk)
}
