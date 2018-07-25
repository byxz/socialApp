//
//  MapPresenter.swift
//  socialApp
//
//  Created by Mac on 25.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import CoreLocation

protocol MapViewOutput {
    func didLoad()
    func place(at coordinate: CLLocationCoordinate2D)
}

final class MapPresenter {
    private var router: MapRouter?
    private weak var view: MapView?
    
    private var locationService: LocationService = LocationService()
    private var geoService: GeoService = GeoService()
}

extension MapPresenter: MapViewOutput {
    func didLoad() {
        locationService.authorize()
    }
    
    func place(at coordinate: CLLocationCoordinate2D) {
        // smoothly adding location
        let annotation = UserAnnotation(coordinate: coordinate)
        view?.add(annotation: annotation)
        
        // trying to fetch details
        geoService.place(at: coordinate) { [weak self] mark, _ in
            guard let markAnnotation = mark?.annotation else { return }
            
            // smoothly replacing simple annotation with detailed one
            self?.view?.remove(annotation: annotation)
            self?.view?.add(annotation: markAnnotation)
        }
    }
}

extension MapPresenter {
    func attach(router: MapRouter) {
        self.router = router
    }
    
    func attach(view: MapView) {
        self.view = view
    }
}
