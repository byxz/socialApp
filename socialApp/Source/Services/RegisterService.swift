//
//  RegisterService.swift
//  socialApp
//
//  Created by Mac on 18.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import Foundation

class RegisterService {
    
    enum Error: Swift.Error {
        case badUrl
        case badJson
        case incorrectData
        case api(error: Swift.Error)
    }
    
    func register(name: String, description: String, email: String, password: String, image: String, completion: @escaping (String?, Error?) -> Void) {
        let urlString = Config.baseUrl + "/register"
        
        guard let url = URL(string: urlString) else {
            completion(nil, .badUrl)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let dict = ["name": name, "description": description, "email": email, "password": password, "image": image]
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
