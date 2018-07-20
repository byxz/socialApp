//
//  RegisterViewController.swift
//  socialApp
//
//  Created by Mac on 12.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import UIKit

protocol RegisterPresenterProtocol {
    func register(name: String, email: String, password: String, description: String, image: UIImage?)
}

final class RegisterViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var emailField: UITextField!
    @IBOutlet private var passwordField: UITextField!
    @IBOutlet private var descriptionView: UITextView!
    
    private var presenter: RegisterPresenterProtocol?
    
    // MARK: - Attachments
    
    func attach(presenter: RegisterPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - IBActions
    
    @IBAction private func onRegisterClick(_ sender: UIButton) {
        guard let name = nameField.text,
            let email = emailField.text,
            let password = passwordField.text,
            let description = descriptionView.text else {
                // IS EMPTY
                // TEXT USER
                return
        }
        
        // CHECK IF EMPTY
        
        let image = imageView.image
        presenter?.register(name: name, email: email, password: password, description: description, image: image)
    }
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - RegisterView

extension RegisterViewController: RegisterView {
    func handle(error: Error) {
        print(error)
    }
}
