//
//  WeatherViewController.swift
//  Weathery
//
//  Created by Anon Account on 27.06.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchLine: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchLineSetup()
    }
    
    
    
    func getWeather() {
//        let urlString = "https://goweather.herokuapp.com/weather"
        
    }
    
    func searchLineSetup() {
        searchLine.delegate = self
    }
    

}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
