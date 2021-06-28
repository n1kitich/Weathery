//
//  WeatherViewController.swift
//  Weathery
//
//  Created by Anon Account on 27.06.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchLine: UITextField!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherModel: WeatherModel?
    let networkService = NetworkService()
    
    let segueID = "goToHistory"
    let url = "https://goweather.herokuapp.com/weather"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeLabel.isHidden = true
        descriptionLabel.isHidden = true
        temperatureLabel.isHidden = true
        
        searchLineSetup()
    }
    
    @IBAction func toForecastHistory(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: segueID, sender: nil)
    }
    
    func searchLineSetup() {
        searchLine.delegate = self
        searchLine.autocapitalizationType = .words
        searchLine.returnKeyType = .search
        // return button is anactive if the textField is empty
        searchLine.enablesReturnKeyAutomatically = true
    }
  
    func displayData() {
        placeLabel.isHidden = false
        descriptionLabel.isHidden = false
        temperatureLabel.isHidden = false
        
        let weatherDescription = weatherModel!.description + ", " + weatherModel!.wind
        placeLabel.text = searchLine.text
        descriptionLabel.text = weatherDescription
        temperatureLabel.text = weatherModel?.temperature
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
                self.displayData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
