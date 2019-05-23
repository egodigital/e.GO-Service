//
//  BeaconController.swift
//  e.GO Service
//
//  Created by Felix Wehnert on 23.05.19.
//  Copyright © 2019 Jonas Schlabertz. All rights reserved.
//

import Foundation
import CoreLocation
import UserNotifications

class BeaconController: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager

    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
   
}
