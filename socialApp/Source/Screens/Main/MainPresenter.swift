//
//  MainPresenter.swift
//  socialApp
//
//  Created by Mac on 25.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

protocol MainViewOutput {
    func didLoad()
    func didClickAdd()
}

final class MainPresenter {
    private var router: MainRouter?
    private weak var view: MainView?
}

extension MainPresenter: MainViewOutput {
    func didClickAdd() {
        router?.openMap()
    }
    
    func didLoad() {
        if !Auth.current.isAuthorized {
            router?.authorize()
        }
    }
}

extension MainPresenter {
    func attach(router: MainRouter) {
        self.router = router
    }
    
    func attach(view: MainView) {
        self.view = view
    }
}
