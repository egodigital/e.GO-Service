//
//  VehicleSignalList.swift
//  e.GO Service
//
//  Created by Jonas Schlabertz on 23.05.19.
//  Copyright © 2019 Jonas Schlabertz. All rights reserved.
//

import Foundation

enum OnOffStatus: String, Codable {
    case on
    case off
}

struct VehicleSignalList: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case batteryHealth = "battery_health"
        case brakeFluidLevel = "brake_fluid_level"
        case wipingWaterLevel = "wiping_water_level"
        case tirePressureBackLeft = "tire_pressure_back_left"
        case tirePressureBackRight = "tire_pressure_back_right"
        case tirePressureFrontLeft = "tire_pressure_front_left"
        case tirePressureFrontRight = "tire_pressure_front_right"
        case motorControlLamp = "motor_control_lamp"
    }

    let batteryHealth: Double
    let brakeFluidLevel: Double
    let wipingWaterLevel: Double
    let tirePressureBackLeft: Double
    let tirePressureBackRight: Double
    let tirePressureFrontLeft: Double
    let tirePressureFrontRight: Double
    let motorControlLamp: OnOffStatus
    
}
