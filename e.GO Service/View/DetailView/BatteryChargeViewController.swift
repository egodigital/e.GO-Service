//
//  BatteryChargeViewController.swift
//  e.GO Service
//
//  Created by Felix Wehnert on 23.05.19.
//  Copyright © 2019 Jonas Schlabertz. All rights reserved.
//

import UIKit

class BatteryChargeViewController: UIViewController {
    
    @IBOutlet weak var batteryChargeView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var vehicleSignalList: VehicleSignalList!
    
    override func viewDidLoad() {
        setLabelText(number: 100)
    }
    
    func setLabelText(number: Int) {
        self.mainLabel.text = "Battery charge is at \((number))%"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let charge = vehicleSignalList.batteryCharge / 100
        
        let height = self.view.frame.height - self.view.safeAreaInsets.bottom - self.view.safeAreaInsets.top
        
        UIView.animate(withDuration: 0.5) {
            self.topConstraint.constant = height * CGFloat((1-charge))
            self.batteryChargeView.backgroundColor = UIColor(hue: CGFloat((charge) * 120)/360, saturation: 1, brightness: 1, alpha: 1)
            self.view.layoutIfNeeded()
        }
        
        let duration: Double = 0.35 //seconds
        let endValue: Int = 100-Int(vehicleSignalList.batteryCharge)
        DispatchQueue.global().async {
            for i in 0 ... endValue {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.setLabelText(number: Int(100-i))
                }
            }
        }
    }
}

