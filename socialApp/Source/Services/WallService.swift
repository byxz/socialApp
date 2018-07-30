//
//  WallService.swift
//  socialApp
//
//  Created by Mac on 26.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import Foundation

func makePublication(latitude: Float, longitude: Float, description: String, completion: @escaping (Error?) -> Void) {
    let urlString = "http://localhost:8080" + "/wall"
    guard let url = URL(string: urlString) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    guard let key = Auth.current.key else { return }
    request.setValue(key, forHTTPHeaderField: "Key")
    
    let dict: [String: Any] = ["lat": latitude, "lng": longitude, "description": description]
    let json = try? JSONSerialization.data(withJSONObject: dict, options: [])
    request.httpBody = json
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
        if let error = error {
            completion(error)
            return
        }
        
        guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let dict = json as? [String: Any] else {
                completion(nil)
                return
        }
        
        if let errorDict = dict["error"] as? [String: Any] {
            let code = errorDict["code"] as? Int ?? 0
            let message = errorDict["message"] as? String ?? ""
            let nsError = NSError(domain: "self", code: code, userInfo: [NSLocalizedDescriptionKey: message])
            completion(nsError)
            return
        }
        
        completion(nil)
    })
    task.resume()
}

func getPublications(id: String, offset: Int, quantity: Int, completion: @escaping ([Any]?, Error?) -> Void) {
    let urlString = "http://localhost:8080" + "/wall" + "?" + "id=\(id)" + "&" + "offset=\(offset)" + "&" + "quantity=\(quantity)"
    
    // getPublications(id: "self", offset: 0, quantity: 10, completion: { _, _ in })
    // http://localhost:8080/wall?id=self&offset=0&quantity=10
    
    guard let url = URL(string: urlString) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    guard let key = Auth.current.key else { return }
    request.setValue(key, forHTTPHeaderField: "Key")
    
    let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let data = data else {
            completion(nil, nil)
            return
        }
        
        if let error = try? JSONDecoder().decode(ErrorDict.self, from: data) {
            completion(nil, error)
            return
        }
        
        let array = try? JSONDecoder().decode([Location].self, from: data)
        completion(array, nil)
    }
    task.resume()
}
