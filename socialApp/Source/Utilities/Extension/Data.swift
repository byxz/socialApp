//
//  Data.swift
//  socialApp
//
//  Created by Mac on 30.07.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import Foundation

extension Data {
    var json: Any? {
        let string = String(data: self, encoding: .utf8)
        let cleanString = string?.replacingOccurrences(of: "'", with: "\"")
        guard let data = cleanString?.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: [])
    }
}
