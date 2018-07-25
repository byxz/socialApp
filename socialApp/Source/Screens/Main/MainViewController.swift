//
//  MainViewController.swift
//  socialApp
//
//  Created by Mac on 25.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import UIKit

protocol MainView: class {
    
}

final class MainViewController: UIViewController {
    private var output: MainViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoad()
    }
    

}

private extension MainViewController {
    
    @IBAction func onAddClick(_ sender: UIButton) {
        output?.didClickAdd()
    }
}

extension MainViewController {
    func attach(output: MainViewOutput) {
        self.output = output
    }
}

extension MainViewController: MainView {
    
}
