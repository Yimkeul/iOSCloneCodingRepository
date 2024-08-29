//
//  MypointViewModel.swift
//  TossBenefitTab
//
//  Created by yimkeul on 8/29/24.
//

import Foundation
import Combine

final class MypointViewModel {
    @Published var point: MyPoint
    
    init(point: MyPoint) {
        self.point = point
    }
    
}
