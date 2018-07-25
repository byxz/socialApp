//
//  MapScreen.swift
//  socialApp
//
//  Created by Mac on 25.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import UIKit

protocol MapRouter {
    
}

final class MapScreen {
    private weak var viewController: MapViewController?
    private weak var presenter: MapPresenter?
    
    private func instantiateViewController() -> MapViewController {
        guard let viewController = R.storyboard.map.mapViewController() else { fatalError("Failed to load MapViewСontroller") }
        
        let presenter = MapPresenter()
        presenter.attach(router: self)
        presenter.attach(view: viewController)
        viewController.attach(output: presenter)
        
        self.presenter = presenter
        self.viewController = viewController
        
        return viewController
    }
    
    func push(to navigation: UINavigationController) {
        let viewController = instantiateViewController()
        navigation.pushViewController(viewController, animated: true)
    }
}

extension MapScreen: MapRouter {
    
}
