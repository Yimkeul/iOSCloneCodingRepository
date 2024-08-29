//
//  BenefitListViewModel.swift
//  TossBenefitTab
//
//  Created by yimkeul on 8/29/24.
//

import Foundation
import Combine

final class BenefitListViewModel {
    @Published var todaySectionItems: [AnyHashable] = []
    @Published var otherSectionItems: [AnyHashable] = []
    
    let benefitDidTapped = PassthroughSubject<Benefit, Never>()
    let pointDidTapped = PassthroughSubject<MyPoint, Never>()
    
    func fetchItems() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.todaySectionItems = TodaySectionItem(point: .default, today: .today).sectionItems // 포인트, 오늘의 혜택
            self.otherSectionItems = Benefit.others // 혜택, 나머지 리스트
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.otherSectionItems = Benefit.others // 혜택, 나머지 리스트
        })
    }
    
}
