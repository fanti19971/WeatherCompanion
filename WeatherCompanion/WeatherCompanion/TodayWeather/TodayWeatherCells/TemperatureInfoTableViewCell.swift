//
//  TemperatureInfoTableViewCell.swift
//  WeatherCompanion
//
//  Created by Aleksandr  Babarikin  on 7/9/20.
//  Copyright © 2020 Aleksandr  Babarikin . All rights reserved.
//

import UIKit

class TemperatureInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    func fillUI(with data: UserTempInfo) {
        tempMinLabel.text = data.tempMin + " °C"
        tempMaxLabel.text = data.tempMax + " °C"
        feelsLikeLabel.text = data.tempFeelsLike + " °C"
        pressureLabel.text = data.pressure
        humidityLabel.text = data.humidity
    }
    
}
