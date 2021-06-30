//
//  WeatherViewController.swift
//  Weathery
//
//  Created by Anon Account on 27.06.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchLine: UISearchBar!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    @IBOutlet var tempForecat: [UILabel]!
    @IBOutlet var windForecat: [UILabel]!
    
    
    var weatherModel: WeatherModel?
    let networkService = NetworkService()
    
    let segueID = "goToHistory"
    let url = "https://goweather.herokuapp.com/weather"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeLabel.text = ""
        descriptionLabel.text = ""
        temperatureLabel.text = ""
        windLabel.text = ""
        
//        hideLabels(true)
        searchLineSetup()
    }
    
    @IBAction func toForecastHistory(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: segueID, sender: nil)
    }
    
    func searchLineSetup() {
        searchLine.delegate = self
        searchLine.autocapitalizationType = .words
        searchLine.returnKeyType = .search
        searchLine.enablesReturnKeyAutomatically = true
    }
  
    func displayData() {
//        hideLabels(false)
        
        placeLabel.text = searchLine.text
        windLabel.text = weatherModel!.wind
        descriptionLabel.text = weatherModel!.description
        temperatureLabel.text = weatherModel?.temperature
        
        let forecast = weatherModel?.forecast
        for index in 0...2 {
            tempForecat[index].text = forecast![index].temperature
            windForecat[index].text = forecast![index].wind
        }
    }
    
//    func hideLabels(_ bool: Bool) {
//        placeLabel.isHidden = bool
//        descriptionLabel.isHidden = bool
//        temperatureLabel.isHidden = bool
//        windLabel.isHidden = bool
//    }
    
}

// MARK: - TextField Delegate
extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            searchWeather(by: text)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchWeather(by place: String) {
        networkService.fetchRequest(url: url, place: place) { result in
            switch result {
            case .success(let forecast):
                DispatchQueue.global(qos: .userInitiated).async {
                    self.weatherModel = forecast
                }
                self.displayData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
