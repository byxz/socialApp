//
//  LoginPresenter.swift
//  socialApp
//
//  Created by Mac on 12.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import UIKit
import KeychainSwift

protocol LoginRouter: class {
    func openRegistration()
    func login()
}

protocol LoginInteractor: class {
     func loginer(email: String, password: String, completion: @escaping (String?, Error?) -> Void)
}

protocol LoginView: class {
    func handle(error: Error)
}

final class LoginPresenter {
    private var router: LoginRouter
    private var interactor: LoginInteractor
    private weak var view: LoginView?
    
    init(router: LoginRouter, interactor: LoginInteractor, view: LoginView) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func loginer(email: String, password: String) {
        interactor.loginer(email: email, password: password) { [weak self] token, error in
            if let error = error {
                self?.view?.handle(error: error)
                return
            }
            
            guard let token = token else {
                let error = NSError(domain: "self", code: 0, userInfo: [NSLocalizedDescriptionKey: "No token"])
                self?.view?.handle(error: error)
                return
            }
            
            Auth.current.key = token
            //????
            self?.router.login()
        }
    }
    
    func registrationClick() {
        router.openRegistration()
    }
}
