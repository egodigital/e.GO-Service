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
    
    enum CellType: CaseIterable {
        case tire, brake, wipingWater, motorControlLamp, batteryHealth, batteryCharge
    }
    
    var type: CellType? {
        didSet {
            if let type = type {
                switch type {
                case .batteryCharge:
                    icon.image = UIImage(named: "batteryCharge")
                    mainLabel.text = "Battery charge is \(vehicleSignalList.batteryChargeGood() ? "good" : "low")"
                    colorIndicator.backgroundColor = vehicleSignalList.batteryChargeGood() ? UIColor.green : UIColor.red
                case .tire:
                    icon.image = UIImage(named: "tire")
                    mainLabel.text = "Tire pressure is \(vehicleSignalList.tirePressureGood() ? "good" : "low")"
                    colorIndicator.backgroundColor = vehicleSignalList.tirePressureGood() ? UIColor.green : UIColor.red
                case .brake:
                    icon.image = UIImage(named: "brake")
                    mainLabel.text = "Brake fluid level is \(vehicleSignalList.brakeFluidLevelGood() ? "good" : "bad")"
                    colorIndicator.backgroundColor = vehicleSignalList.brakeFluidLevelGood() ? UIColor.green : UIColor.red
                case .wipingWater:
                    icon.image = UIImage(named: "wipingWater")
                    mainLabel.text = "Wiping water level is \(vehicleSignalList.wipingWaterLevelGood() ? "good" : "low")"
                    colorIndicator.backgroundColor = vehicleSignalList.wipingWaterLevelGood() ? UIColor.green : UIColor.red
                case .motorControlLamp:
                    icon.image = UIImage(named: "motor")
                    mainLabel.text = "Motor control lamp is \(vehicleSignalList.motorControlLamp == .on ? "on" : "off")"
                    colorIndicator.backgroundColor = vehicleSignalList.motorControlLamp == .off ? UIColor.green : UIColor.red
                case .batteryHealth:
                    icon.image = UIImage(named: "batteryHealth")
                    mainLabel.text = "Battery health is \(vehicleSignalList.brakeFluidLevelGood() ? "good" : "bad")"
                    colorIndicator.backgroundColor = vehicleSignalList.brakeFluidLevelGood() ? UIColor.green : UIColor.red
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = colorIndicator.backgroundColor
        super.setSelected(selected, animated: animated)
        
        if selected {
            colorIndicator.backgroundColor = color
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = colorIndicator.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            colorIndicator.backgroundColor = color
        }
    }
    
}
