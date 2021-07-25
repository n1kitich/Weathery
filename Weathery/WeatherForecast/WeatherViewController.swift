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
    
    //var currentWeather: CurrentWeather?
    let dataFetcher = NetworkDataFetcher()
    lazy var coreDataManager = CoreDataManager(modelName: "WeatherCD")
    var locationManager = CLLocationManager()
    
    let segueID = "goToHistory"
    
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
    
    func updateUI(with currentWeather: CurrentWeather) {
        
        let date = Int(currentWeather.dt).getDateStringFromUnix()
        let weather = currentWeather.weather.first
        
        placeLabel.text = currentWeather.name
        updatedTimeLabel.text = String(date)
        descriptionLabel.text = weather?.weatherDescription
        temperatureLabel.text = String(currentWeather.main.temp)
        feellikeLabel.text = "Feel like " + String(currentWeather.main.feelsLike)
        windLabel.text = String(currentWeather.wind.speed) + " m/s"
        pressureLabel.text = String(currentWeather.main.pressure)
        humidityLabel.text = String(currentWeather.main.humidity)
    }
    
    func saveDataToStore(_ currentWeather: CurrentWeather) {
        
        let current = NSEntityDescription.insertNewObject(forEntityName: "Current", into: coreDataManager.managedContext) as! Current
        let weather = NSEntityDescription.insertNewObject(forEntityName: "Weather", into: coreDataManager.managedContext) as! Weather
        let main = NSEntityDescription.insertNewObject(forEntityName: "Main", into: coreDataManager.managedContext) as! Main
        let wind = NSEntityDescription.insertNewObject(forEntityName: "Wind", into: coreDataManager.managedContext) as! Wind
                
        current.dt = Int32(currentWeather.dt)
        current.name = currentWeather.name
        main.temp = currentWeather.main.temp
        wind.speed = currentWeather.wind.speed
        weather.weatherDescription = currentWeather.weather.first?.weatherDescription
          
        current.main = main
        current.weather = weather
        current.wind = wind
                
        coreDataManager.saveContext()
    }
    
    func searchWeather(by place: String) {
        dataFetcher.fetchData(accessKey: "8d86b5aee21d595dc197f8f8a066a108", place: place) {
            result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.updateUI(with: weather)
                    self.saveDataToStore(weather)
                }
            case .failure(let error):
                fatalError("\(error)")
            }
        }
    }
    
}

// MARK: - SearchBar Delegate
extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text else { return }
        searchWeather(by: text)
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
