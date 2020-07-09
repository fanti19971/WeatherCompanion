//
//  MainWeatherInfoTableViewCell.swift
//  WeatherCompanion
//
//  Created by Aleksandr  Babarikin  on 7/9/20.
//  Copyright © 2020 Aleksandr  Babarikin . All rights reserved.
//

import UIKit

class MainWeatherInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fillUI(with data: UserMainWeatherInfo) {
        cityNameLabel.text = data.cityName
        tempLabel.text = data.temp + " °C"
        descriptionLabel.text = data.description
    }
}

extension UITableViewCell {
    static func cellId() -> String {
        return String(describing: Self.self)
    }
}
