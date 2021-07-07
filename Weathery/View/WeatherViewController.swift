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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet var tempForecat: [UILabel]!
    @IBOutlet var windForecat: [UILabel]!
    
    var weatherModel: WeatherModel?
    let networkService = NetworkService()
    var managedObjectContext: NSManagedObjectContext!
    
    let segueID = "goToHistory"
    let url = "https://goweather.herokuapp.com/weather"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideLabels()
        searchLineSetup()
        
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    }
    
    @IBAction func toForecastHistory(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: segueID, sender: nil)
    }
    
    func saveContext() {
        let newWeather = NSEntityDescription.insertNewObject(forEntityName: "Weather", into: managedObjectContext) as! Weather
//        newWeather.temperature = weatherModel?.temperature
//        newWeather.wind = weatherModel?.wind
//        newWeather.descript = weatherModel?.description
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func searchLineSetup() {
        searchLine.delegate = self
        searchLine.autocapitalizationType = .words
        searchLine.returnKeyType = .search
        searchLine.enablesReturnKeyAutomatically = true
    }
  
    func displayData() {
        placeLabel.text = searchLine.text
//        windLabel.text = weatherModel!.wind
//        descriptionLabel.text = weatherModel!.description
//        temperatureLabel.text = weatherModel?.temperature
//
//        let forecast = weatherModel?.forecast
        for index in 0...2 {
//            tempForecat[index].text = forecast![index].temperature
//            windForecat[index].text = forecast![index].wind
        }
    }
    
    func hideLabels() {
        placeLabel.text = ""
        descriptionLabel.text = ""
        temperatureLabel.text = ""
        windLabel.text = ""
        
        for index in 0...2 {
            tempForecat[index].text = ""
            windForecat[index].text = ""
        }
    }
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
        hideLabels()
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchWeather(by place: String) {
//        networkService.fetchRequest(url: url, place: place) { result in
//            switch result {
//            case .success(let weather):
//                DispatchQueue.global(qos: .userInitiated).async {
//                    self.weatherModel = weather
//                    self.saveContext()
//                }
//                self.displayData()
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
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
