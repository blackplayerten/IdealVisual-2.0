//
//  ServiceErrors.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 10.12.2021.
//

import Foundation

enum ServiceErrors: Error {
    case noConnection
    case noData
    case notFound
    case unauthorized
    case wrongFields(WrongFieldsNetworkEror)
    case forbidden
    case unknown
    case invalidURL
}

struct WrongFieldsNetworkEror: Error {
    let name: String
    let description: Any

    init(name: String, description: Any) {
        self.name = name
        self.description = description
    }
}
