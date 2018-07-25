//
//  LoginPresenter.swift
//  socialApp
//
//  Created by Mac on 12.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import Foundation

protocol LoginRouter: class {
    func openRegistration()
    func didAuth()
}

protocol LoginInteractor: class {
    
}

protocol LoginView: class {
    
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
    func registrationClick() {
        router.openRegistration()
    }
    
    func didLoginClick() {
        router.didAuth()
    }
}
