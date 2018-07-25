//
//  MapViewController.swift
//  socialApp
//
//  Created by Mac on 25.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import UIKit
import MapKit

import CoreLocation

protocol MapView: class {
    func add(annotation: UserAnnotation)
    func remove(annotation: UserAnnotation)
}

final class MapViewController: UIViewController {
    @IBOutlet private var mapView: MKMapView!
    
    private var output: MapViewOutput?
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoad()
    }
}

private extension MapViewController {
    @IBAction func onLocationButtonClick(_ sender: UIButton) {
        let coordinate = mapView.userLocation.coordinate
        let span = MKCoordinateSpanMake(1, 1)
        let region = MKCoordinateRegionMake(coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func onMapTap(_ sender: UIGestureRecognizer) {
        let location = sender.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        output?.place(at: coordinate)
    }
}

// MARK: - Attachments -

extension MapViewController {
    func attach(output: MapViewOutput) {
        self.output = output
    }
}

// MARK: - MapView -

extension MapViewController: MapView {
    func add(annotation: UserAnnotation) {
        mapView.addAnnotation(annotation)
    }
    
    func remove(annotation: UserAnnotation) {
        mapView.removeAnnotation(annotation)
    }
}

// MARK: - MKMapViewDelegate -

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // guard let annotation = view.annotation else { return }
        // mapView.removeAnnotation(annotation)
    }
}
