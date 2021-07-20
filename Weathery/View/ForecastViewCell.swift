//
//  ForecastViewCell.swift
//  Weathery
//
//  Created by Anon Account on 06.07.2021.
//

import UIKit

class ForecastViewCell: UITableViewCell {
    
    @IBOutlet weak var localtimeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    
    static let cellIdentifier = "Cell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ForecastViewCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
