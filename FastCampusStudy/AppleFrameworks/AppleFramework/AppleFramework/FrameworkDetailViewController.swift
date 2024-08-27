//
//  FrameworkDetailViewController.swift
//  AppleFramework
//
//  Created by yimkeul on 8/26/24.
//

import UIKit
import SafariServices

class FrameworkDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var framework: AppleFramework = AppleFramework(name: "", imageName: "", urlString: "", description: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("Learn More", for: .normal)
        updateUI()
    }
    
    func updateUI() {
        imageView.image = UIImage(named: framework.imageName)
        titleLabel.text = framework.name
        descriptionLabel.text = framework.description
    }
    @IBAction func learnMoreTapped(_ sender: Any) {
        guard let url = URL(string: framework.urlString) else {
            return
        }
        
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
        
    }
}
