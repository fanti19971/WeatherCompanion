//
//  WindInfoTableViewCell.swift
//  WeatherCompanion
//
//  Created by Aleksandr  Babarikin  on 7/9/20.
//  Copyright © 2020 Aleksandr  Babarikin . All rights reserved.
//

import UIKit

class WindInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var degLabel: UILabel!
    
    func fillUI(with data: Wind){
        speedLabel.text = "\(data.speed)"
        degLabel.text = "\(data.deg)"
    }
}
