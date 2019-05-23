//
//  ServiceTypeCell.swift
//  e.GO Service
//
//  Created by Felix Wehnert on 23.05.19.
//  Copyright © 2019 Jonas Schlabertz. All rights reserved.
//

import UIKit

class ServiceTypeCell: UITableViewCell {
    
    @IBOutlet var icon: UIImageView!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet weak var colorIndicator: UIView!
    
    var vehicleSignalList: VehicleSignalList!
    
    enum CellType {
        case tire, brake, wipingWater, motorControlLamp, batteryHealth
    }
    
    var type: CellType? {
        didSet {
            if let type = type {
                switch type {
                case .tire:
                    icon.image = UIImage(named: "tire")
                    mainLabel.text = "Tire pressure is \(vehicleSignalList.tirePressureGood() ? "good" : "bad")"
                    colorIndicator.backgroundColor = vehicleSignalList.tirePressureGood() ? UIColor.green : UIColor.red
                case .brake:
                    icon.image = UIImage(named: "tire")
                case .wipingWater:
                    icon.image = UIImage(named: "tire")
                case .motorControlLamp:
                    icon.image = UIImage(named: "tire")
                case .batteryHealth:
                    icon.image = UIImage(named: "tire")
                }
            }
        }
    }
    
    override func awakeFromNib() {
        
    }
    
}
