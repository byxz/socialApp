//
//  LoginViewController.swift
//  socialApp
//
//  Created by Mac on 12.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import UIKit

protocol LoginPresenterProtocol {
    func registrationClick()
    func didLoginClick()
}

final class LoginViewController: UIViewController {
    
    @IBOutlet private var emailField: UITextField!
    @IBOutlet private var passwordField: UITextField!
    
    private var presenter: LoginPresenterProtocol?
    
    
    // MARK: - Attachments
    
    func attach(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
    
    
    // MARK: - IBActions
    
    @IBAction private func onLoginClick(_ sender: UIButton) {
        presenter?.didLoginClick()
    }
    
    @IBAction private func onRegisterClick(_ sender: UIButton) {
        presenter?.registrationClick()
    }
}

// MARK: - LoginView

extension LoginViewController: LoginView {
    
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case emailField: passwordField.becomeFirstResponder()
        default: textField.resignFirstResponder()
        }
        
        return true
    }
}
