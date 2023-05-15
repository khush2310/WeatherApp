//
//  ViewController.swift
//  WeatherApp
//
//  Created by Khushboo Jain on 2023-05-09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    var weatherData: Daily!
    var apiManager = APIManager()
    var isLoading = false
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    @IBAction func refreshClicked(_ sender: UIButton) {
        if isLoading { return }
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        fetchData()
    }
    
    func fetchData(){
        isLoading = true
        apiManager.performRequest { [weak self] weather, error in
            if let _ = error {
                self?.isLoading = false
                self?.showAlert()
            } else {
                self?.isLoading = false
                self?.weatherData = weather
                self?.setUpCards()
            }
            
        }
    }

    func setUpCards() {
        DispatchQueue.main.async{ [self] in
            guard let data = weatherData else { return }
            for i in 0..<data.dateCount() {
                let weather = data.getData(at: i)
                let view = TemperatureParametersView()
                view.setUpView(weather: weather)
                stackView.addArrangedSubview(view)
            }
        }
    }
    func showAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Oops!", message: "Something went wrong!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
