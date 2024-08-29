//
//  MyPoint.swift
//  TossBenefitTab
//
//  Created by yimkeul on 8/29/24.
//

import Foundation

struct MyPoint: Hashable {
    var point: Int
}
extension MyPoint {
    static let `default` = MyPoint(point: 0)
}
