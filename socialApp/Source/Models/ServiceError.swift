//
//  ServiceError.swift
//  socialApp
//
//  Created by Mac on 30.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

struct ServiceError: Decodable {
    let code: Int
    let message: String
}
