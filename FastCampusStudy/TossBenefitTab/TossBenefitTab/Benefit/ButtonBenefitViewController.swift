//
//  ButtonBenefitViewController.swift
//  TossBenefitTab
//
//  Created by yimkeul on 8/29/24.
//

import UIKit
import Combine

class ButtonBenefitViewController: UIViewController {



    @IBOutlet weak var ctaButton: UIButton!
    @IBOutlet weak var vStackView: UIStackView!

    var viewModel: ButtonBenefitViewModel!
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel.fetchDetails()
    }

    private func bind() {
        viewModel.$benefit
            .receive(on: RunLoop.main)
            .sink { benefit in
            self.ctaButton.setTitle(benefit.ctaTitle, for: .normal)
        }
            .store(in: &subscriptions)

        viewModel.$benefitDetails
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { details in
            self.addGuides(details: details)
        }
            .store(in: &subscriptions)
    }

    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        self.ctaButton.layer.masksToBounds = true
        self.ctaButton.layer.cornerRadius = 5
    }

    private func addGuides(details: BenefitDetails) {
        let guideView = vStackView.arrangedSubviews.filter { $0 is BenefitGuideView }
        guard guideView.isEmpty else { return }
        
        let guideViews: [BenefitGuideView] = details.guides.map {
            let guideView = BenefitGuideView(frame: .zero)
            guideView.icon.image = UIImage(systemName: $0.iconName)
            guideView.title.text = $0.guide
            return guideView
        }

        guideViews.forEach {
            self.vStackView.addArrangedSubview($0)
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    }



}
