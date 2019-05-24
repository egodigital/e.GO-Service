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
        case batteryCharge = "battery_state_of_charge"
        case mileage
    }

    let batteryHealth: Double
    let brakeFluidLevel: Double
    let wipingWaterLevel: Double
    let tirePressureBackLeft: Double
    let tirePressureBackRight: Double
    let tirePressureFrontLeft: Double
    let tirePressureFrontRight: Double
    let batteryCharge: Double
    let motorControlLamp: OnOffStatus
    let mileage: Int
    
}

extension VehicleSignalList {
    func tirePressureGood() -> Bool {
        return
            self.tirePressureBackLeft   >= 2 &&
            self.tirePressureBackRight  >= 2 &&
            self.tirePressureFrontLeft  >= 2 &&
            self.tirePressureFrontRight >= 2
    }
    
    func brakeFluidLevelGood() -> Bool {
        return self.brakeFluidLevel >= 0.75
    }
    
    func wipingWaterLevelGood() -> Bool {
        return self.wipingWaterLevel >= 0.20
    }
    
    func batteryHealthLevelGood() -> Bool {
        return self.batteryHealth > 0.20
    }
    
    func batteryChargeGood() -> Bool {
        return batteryCharge > 50
    }
    
    func tireHealthGood() -> Bool {
        return mileage <= 40000
    }
    
}
