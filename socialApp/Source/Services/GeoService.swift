//
//  GeoService.swift
//  socialApp
//
//  Created by Mac on 25.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import CoreLocation

class GeoService {
    enum Error {
        case noPlaceFound
        case other(Swift.Error)
    }
    
    private let geocoder = CLGeocoder()
    
    func place(at coordinate: CLLocationCoordinate2D, completion: @escaping ((Place?, Error?) -> Void)) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        // to find coordinates of address
        // coder.geocodeAddressString(<#T##addressString: String##String#>, completionHandler: <#T##CLGeocodeCompletionHandler##CLGeocodeCompletionHandler##([CLPlacemark]?, Error?) -> Void#>)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                completion(nil, .other(error))
                return
            }
            
            guard let placemark = placemarks?.first else {
                completion(nil, .noPlaceFound)
                return
            }
            
            let place = Place(placemark: placemark)
            completion(place, nil)
        }
    }
    
    func cancel() {
        geocoder.cancelGeocode()
    }
}
