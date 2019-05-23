//
//  ServiceTypeCell.swift
//  e.GO Service
//
//  Created by Felix Wehnert on 23.05.19.
//  Copyright © 2019 Jonas Schlabertz. All rights reserved.
//

import UIKit

class ServiceTypeCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    
    enum CellType {
        case tire, brake, wipingWater, motorControlLamp, batteryHealth
    }
    
    var type: CellType? {
        didSet {
            if let type = type {
                switch type {
                case .tire:
                    icon.image = UIImage(named: "tire")
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
    
    
}
