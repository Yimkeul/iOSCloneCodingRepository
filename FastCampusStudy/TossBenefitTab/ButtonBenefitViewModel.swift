//
//  ButtonBenefitViewModel.swift
//  TossBenefitTab
//
//  Created by yimkeul on 8/29/24.
//

import Foundation
import Combine

final class ButtonBenefitViewModel {
    @Published var benefit: Benefit
    @Published var benefitDetails: BenefitDetails?
    
    init(benefit: Benefit, benefitDetails: BenefitDetails? = nil) {
        self.benefit = benefit
        self.benefitDetails = benefitDetails
    }
    
    func fetchDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.benefitDetails = .default
        })
    }
}
