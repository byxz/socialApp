//
//  AuthScreen.swift
//  socialApp
//
//  Created by Mac on 20.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import UIKit

final class AuthScreen {
    private weak var navigationController: UINavigationController?
    private var service: AuthService = AuthService()
    
    private var window: UIWindow?
    
    func open() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowLevel = UIWindowLevelAlert
        start(on: window)
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
    func close() {
        self.window?.isHidden = true
        self.window = nil
    }
    
    private func start(on window: UIWindow) {
        guard let viewController = R.storyboard.auth.loginViewController() else {
            fatalError("Unable to instantiate LoginViewController")
        }
        
        let presenter = LoginPresenter(router: self, interactor: service, view: viewController)
        viewController.attach(presenter: presenter)
        
        let navigation = UINavigationController()
        navigationController = navigation
        navigation.viewControllers = [viewController]
        window.rootViewController = navigation
    }
}

// MARK: - LoginRouter -

extension AuthScreen: LoginRouter {

    func openRegistration() {
        guard let viewController = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else {
            fatalError("Unable to instantiate RegisterViewController")
        }
        
        let presenter = RegisterPresenter(router: self, interactor: service, view: viewController)
        viewController.attach(presenter: presenter)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - RegisterRouter

extension AuthScreen: RegisterRouter {
    func didRegister() {
        close()
    }
    
    func didAuth() {
        close()
    }
}
