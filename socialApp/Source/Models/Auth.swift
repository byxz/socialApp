//
//  Auth.swift
//  spalahbook
//
//  Created by Michael on 7/19/18.
//  Copyright © 2018 Mission Edition. All rights reserved.
//

import KeychainSwift

class Auth {
    static let current = Auth()
    private let keychain = KeychainSwift()
    private let storeIdentifire: String = "Key"
    
    var key: String? {
        set {
            if let newValue = newValue {
                keychain.set(newValue, forKey: storeIdentifire)
            } else {
                keychain.delete(storeIdentifire)
            }
            
        }
        get {
            return keychain.get(storeIdentifire)
        }
    }
    
    var isAuthorized: Bool {
        return key != nil && key?.isEmpty == false
    }
}

