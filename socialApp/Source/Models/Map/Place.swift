//
//  Place.swift
//  socialApp
//
//  Created by Mac on 25.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import CoreLocation

struct Place {
    private let placemark: CLPlacemark
    
    init(placemark: CLPlacemark) {
        self.placemark = placemark
    }
    
    var annotation: UserAnnotation? {
        guard let coordinate = placemark.location?.coordinate else { return nil }
        return UserAnnotation(coordinate: coordinate, title: placemark.name, subtitle: placemark.postalCode)
    }
}
