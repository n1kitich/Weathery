//
//  ForecastViewCell.swift
//  Weathery
//
//  Created by Anon Account on 06.07.2021.
//

import UIKit

class SearchHistoryViewCell: UITableViewCell {
    
    @IBOutlet weak var localtimeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var descript: UILabel!
    
    static let cellIdentifier = "Cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchHistoryViewCell", bundle: nil)
    }
    
    private func setupLabel() {
        temperature.textColor = temperature.textColor?.withAlphaComponent(0.6)
        descript.textColor = descript.textColor?.withAlphaComponent(0.6)
    }
}
