//
//  SymbolViewController.swift
//  SymbolRoller
//
//  Created by yimkeul on 8/21/24.
//

import UIKit

class SymbolViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    let symbols: [String] = ["sun.min", "moon", "cloud", "wind", "snowflake"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: 심볼에서, 하나를 임의로 추출해서 이미지와 텍스트를 설정을 한다.
        reload()
    }
    

    @IBAction func buttonTapped(_ sender: Any) {
        reload()
    }
    
    func reload() {
        if let symbol = symbols.randomElement() {
            imageView.image = UIImage(systemName: symbol)
            label.text = symbol
        }
    }
    
}

