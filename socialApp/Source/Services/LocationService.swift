//
//  LocationService.swift
//  socialApp
//
//  Created by Mac on 25.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import CoreLocation

class LocationService {
    private let manager = CLLocationManager()
    
    func authorize() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}
