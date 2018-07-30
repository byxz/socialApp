//
//  ErrorDict.swift
//  socialApp
//
//  Created by Mac on 30.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

struct ErrorDict: Decodable, Error {
    let error: ServiceError
}
