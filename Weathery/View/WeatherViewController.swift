//
//  WeatherViewController.swift
//  Weathery
//
//  Created by Anon Account on 27.06.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchLine: UITextField!
    
    var weatherModel: WeatherModel?
    let networkService = NetworkService()
    
    let segueID = "goToHistory"
    let url = "https://goweather.herokuapp.com/weather"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchLineSetup()
    }
    
    @IBAction func toForecastHistory(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: segueID, sender: nil)
    }
    
    func searchLineSetup() {
        searchLine.delegate = self
        searchLine.returnKeyType = .search
        // return button is anactive if the textField is empty
        searchLine.enablesReturnKeyAutomatically = true
    }
  
}

// MARK: - TextField Delegate
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            searchWeather(by: text)
        }
        return true
    }
    
    func searchWeather(by place: String) {
        networkService.fetchRequest(url: url, place: place) { result in
            switch result {
            case .success(let forecast):
                self.weatherModel = forecast
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
