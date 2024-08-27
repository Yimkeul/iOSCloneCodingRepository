//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by yimkeul on 8/21/24.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    let citys = ["Seoul", "Tokyo", "LA", "Seattle"]
    let weathers = ["cloud.fill", "sun.max.fill", "wind", "cloud.sun.rain.fill"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeButtonTapped(_ sender: Any) {
        cityLabel.text = citys.randomElement()
        if let imageName = weathers.randomElement() {
            weatherImageView.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysOriginal)
        }
        let randomTemp = Int.random(in: 10..<30)
        temperatureLabel.text = String(randomTemp) + "°"
    }


    
//    let temperature =

}

