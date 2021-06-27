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
    let url = "https://goweather.herokuapp.com/weather"
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchLineSetup()
    }
    
    func searchLineSetup() {
        searchLine.delegate = self
        searchLine.returnKeyType = .search
        searchLine.enablesReturnKeyAutomatically = true
    }
    
}

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
                print(self.weatherModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
