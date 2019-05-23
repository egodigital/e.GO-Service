//
//  TireServiceViewController.swift
//  e.GO Service
//
//  Created by Felix Wehnert on 23.05.19.
//  Copyright © 2019 Jonas Schlabertz. All rights reserved.
//

import UIKit

class TireServiceViewController: UIViewController {
    
    @IBOutlet weak var bottomLeftLabel: UILabel!
    @IBOutlet weak var bottomRightLabel: UILabel!
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var topLeftLabel: UILabel!
    
    var vehicleSignalList: VehicleSignalList?
    
    override func viewDidLoad() {
        if let signalList = vehicleSignalList {
            bottomLeftLabel.text = String(signalList.tirePressureBackLeft)
            bottomRightLabel.text = String(signalList.tirePressureBackRight)
            topRightLabel.text = String(signalList.tirePressureFrontRight)
            topLeftLabel.text = String(signalList.tirePressureFrontLeft)
            
            [bottomLeftLabel, bottomRightLabel, topLeftLabel, topRightLabel].filter {Double($0!.text!)! <= 2}.forEach { (label) in
                label?.textColor = .red
            }
            
        }
    }
    
    @IBAction func callServiceWorker(_ sender: Any) {
        let alertController = UIAlertController(title: "Request successful", message: "A service worker is on the way to your car.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true)
    }
    
    
}
