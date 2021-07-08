//
//  WeatherViewController.swift
//  Weathery
//
//  Created by Anon Account on 27.06.2021.
//

import UIKit
import CoreData

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchLine: UISearchBar!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var updatedTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feellikeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var weatherModel: WeatherModel?
    let networkService = NetworkService()
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    let segueID = "goToHistory"
    let url = "https://goweather.herokuapp.com/weather"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideLabels()
        searchLineSetup()
    }
    
    @IBAction func toForecastHistory(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: segueID, sender: nil)
    }
    
    func saveContext() {
//        let newWeather = NSEntityDescription.insertNewObject(forEntityName: "Weather", into: managedObjectContext) as! Weather
//        newWeather.temperature = weatherModel?.current.temperature
//        newWeather.wind = weatherModel?.current.windSpeed
//        newWeather.descript = weatherModel?.current.weatherDescriptions.first
//
//        do {
//            try managedObjectContext.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
    }
    
    func displayData() {
        if let location = weatherModel?.location {
            placeLabel.text = location.name
            updatedTimeLabel.text = location.localtime
        }
        if let current = weatherModel?.current {
            descriptionLabel.text = current.weatherDescriptions.first
            temperatureLabel.text = String(current.temperature)
            feellikeLabel.text = String(current.feelslike)
            windLabel.text = String(current.windSpeed)
            pressureLabel.text = String(current.pressure)
            humidityLabel.text = String(current.humidity)
        }
    }
    
    func searchLineSetup() {
        searchLine.delegate = self
        searchLine.autocapitalizationType = .words
        searchLine.returnKeyType = .search
        searchLine.enablesReturnKeyAutomatically = true
    }
    
    func hideLabels() {
        placeLabel.text = ""
        updatedTimeLabel.text = ""
        descriptionLabel.text = ""
        temperatureLabel.text = ""
        feellikeLabel.text = ""
        windLabel.text = ""
        pressureLabel.text = ""
        humidityLabel.text = ""
    }
}

// MARK: - UISearchBarDelegate
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
        hideLabels()
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchWeather(by place: String) {
        networkService.fetchRequest(
            urlString: "http://api.weatherstack.com/current",
            accessKey: "503bc119ccde64a16ae23720599aa21f",
            query: place
        ) { result in
            switch result {
                case .success(let weather):
                    DispatchQueue.global(qos: .userInitiated).async {
                        self.weatherModel = weather
                        self.saveContext()
                    }
                    self.displayData()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
