//
//  ForecastViewCell.swift
//  Weathery
//
//  Created by Anon Account on 05.07.2021.
//

import UIKit

class ForecastViewCell: UITableViewCell {

    @IBOutlet weak var tempLabel: UILabel?
    @IBOutlet weak var descriptLabel: UILabel?
    
    static let cellIdentifier = "cellIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(temperature: String, description: String) {
        tempLabel?.text = temperature
        descriptLabel?.text = description
    }
    
}
