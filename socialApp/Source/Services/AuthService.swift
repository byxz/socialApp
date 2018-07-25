//
//  AuthService.swift
//  socialApp
//
//  Created by Mac on 17.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import Foundation

final class AuthService {
    enum Error: Swift.Error {
        case badUrl
        case badJson
        case incorrectData
        case api(error: Swift.Error)
    }
    
    private enum ApiKeys: String {
        case name
        case email
        case password
        case description
        case image
    }
    
    enum Path {
        case auth(email: String, password: String)
        case register(name: String, description: String, email: String, password: String, image: String)
        
        var path: String {
            switch self {
            case .auth: return "/auth"
            case .register: return "/register"
            }
        }
        
        var body: [String: Any] {
            switch self {
            case .auth(let email, let password): return [ApiKeys.email.rawValue: email,
                                                         ApiKeys.password.rawValue: password]
            case .register(let name, let description, let email, let password, let image): return [ApiKeys.name.rawValue: name,
                                                                                                   ApiKeys.description.rawValue: description,
                                                                                                   ApiKeys.email.rawValue: email,
                                                                                                   ApiKeys.password.rawValue: password,
                                                                                                   ApiKeys.image.rawValue: image]
            }
        }
    }
    
    func send(task: Path, completion: @escaping (String?, Error?) -> Void) {
        let urlString = Config.baseUrl + task.path
        
        guard let url = URL(string: urlString) else {
            completion(nil, .badUrl)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let dict = task.body
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
            completion(nil, .badJson)
            return
        }
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(nil, .api(error: error))
                return
            }
            
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let dict = json as? [String: String],
                let token = dict["key"] else {
                    completion(nil, .incorrectData)
                    return
            }
            
            completion(token, nil)
        }
        
        task.resume()
    }
}

// MARK: - LoginInteractor

extension AuthService: LoginInteractor {
    
}

// MARK: - RegisterInteractor

extension AuthService: RegisterInteractor {
    func register(name: String, email: String, password: String, description: String, completion: @escaping (String?, Swift.Error?) -> Void) {
        send(task: .register(name: name, description: description, email: email, password: password, image: ""), completion: completion)
    }
}
