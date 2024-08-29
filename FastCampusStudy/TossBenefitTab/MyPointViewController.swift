//
//  MyPointViewController.swift
//  TossBenefitTab
//
//  Created by yimkeul on 8/29/24.
//

import UIKit
import Combine

class MyPointViewController: UIViewController {

    
    @IBOutlet weak var pointLabel: UILabel!
//    let viewModel = MypointViewModel(point: .default)
    var viewModel: MypointViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func bind() {
        viewModel.$point
            .receive(on: RunLoop.main)
            .sink { point in
                self.pointLabel.text = "\(point.point) 원"
            }
            .store(in: &subscriptions)
    }
    
}
