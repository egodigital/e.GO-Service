//
//  ChargeLocation.swift
//  e.GO Service
//
//  Created by Felix Wehnert on 23.05.19.
//  Copyright © 2019 Jonas Schlabertz. All rights reserved.
//

import Foundation
import MapKit

struct ChargeLocation: Codable {
    
    static func loadLocations() -> [ChargeLocation] {
        let url = Bundle.main.url(forResource: "energyStations", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try! decoder.decode([ChargeLocation].self, from: data)
    }
    
    struct ChargePoint: Codable {
        let power: Int
        let count: Int
    }
    
    struct Coordinate: Codable {
        let lat: Double
        let lng: Double
        
        var coord: CLLocationCoordinate2D {
            return CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
    }
    
    let chargepoints: [ChargePoint]
    let name: String
    let network: String
    let coordinates: Coordinate
    
    /*
    "chargepoints": [
    {
    "type": "typ2_socket",
    "current": "acthree",
    "power": 22,
    "count": 2
    }
    ],
    "ge_id": 51,
    "name": "Westfalen Tankstelle",
    "address": {
    "city": "Kerpen",
    "country": "Deutschland",
    "postcode": "50171",
    "street": "Sindorfer Straße 52"
    },
    "coordinates": {
    "lat": 50.882408,
    "lng": 6.694462
    },
    "network": "innogy eRoaming",
    "url": "//www.goingelectric.de/stromtankstellen/Deutschland/Kerpen/Westfalen-Tankstelle-Sindorfer-Strasse-52/51/",
    "fault_report": false,
    "verified": true
     */
}
