//
//  WeatherViewController.swift
//  Weathery
//
//  Created by Anon Account on 27.06.2021.
//

import UIKit
import CoreData
import CoreLocation

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
    @IBOutlet weak var windImage: UIImageView!
    @IBOutlet weak var pressureImage: UIImageView!
    @IBOutlet weak var humidityImage: UIImageView!
    
    var weatherModel: WeatherModel?
    let dataFetcher = NetworkDataFetcher()
    lazy var coreDataManager = CoreDataManager(modelName: "WeatherCD")
    var locationManager = CLLocationManager()
    
    let segueID = "goToHistory"
    let url = "https://goweather.herokuapp.com/weather"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLabels()
        searchLineSetup()
        setupLocationManager()
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
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
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
    
    func displayData() {
        guard let weatherModel = weatherModel else { return }
        
        placeLabel.text = weatherModel.location.name
        updatedTimeLabel.text = weatherModel.location.localtime
        descriptionLabel.text = weatherModel.current.weatherDescriptions.first
        temperatureLabel.text = String(weatherModel.current.temperature)
        feellikeLabel.text = "Feel like: " + String(weatherModel.current.feelslike)
        windLabel.text = String(weatherModel.current.windSpeed)
        pressureLabel.text = String(weatherModel.current.pressure)
        humidityLabel.text = String(weatherModel.current.humidity)
    }
    
    func saveDataToStore() {
        guard let weatherModel = weatherModel else { return }
        
        let weather = NSEntityDescription.insertNewObject(forEntityName: "Weather", into: coreDataManager.managedContext) as! Weather
        let request = NSEntityDescription.insertNewObject(forEntityName: "Request", into: coreDataManager.managedContext) as! Request
        let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: coreDataManager.managedContext) as! Location
        let current = NSEntityDescription.insertNewObject(forEntityName: "Current", into: coreDataManager.managedContext) as! Current
                
        location.name = weatherModel.location.name
        location.localtime = weatherModel.location.localtime
        current.temperature = Int16(weatherModel.current.temperature)
        current.weatherDescriptions = weatherModel.current.weatherDescriptions.first
                
        weather.location = location
        weather.request = request
        weather.current = current
                
        coreDataManager.saveContext()
    }
    
    func searchWeather(by place: String) {
        dataFetcher.fetchData(urlString: "http://api.weatherstack.com/current", accessKey: "503bc119ccde64a16ae23720599aa21f", query: place) { weatherForecast in
            self.weatherModel = weatherForecast
            self.displayData()
        }
    }
    
}

// MARK: - SearchBar Delegate
extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            searchWeather(by: text)
            saveDataToStore()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideLabels()
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let coordinate = "\(latitude),\(longitude)"
            searchWeather(by: coordinate)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updatedTimeLabel.text = "Can`t find your current position"
    }
}
