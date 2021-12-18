//
//  Routing.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 10.12.2021.
//

import Foundation

enum Hosts: String {
    case debug = "http://127.0.0.1/api/"
    case prod = "https://ideal-visual.ru/api/"
}

enum QueryTypes: String {
    case session = "session"
    case account = "account"
    case post = "post"
    case stat = "static"
    case upload = "upload"
}

func configureUrl(host: Hosts, type: QueryTypes) -> URL {
    guard let url = URL(string: host.rawValue + type.rawValue) else {
        Logger.log("configured invalid url: \(String(describing: URL(string: host.rawValue + type.rawValue)))")
        return .init(string: "")!
    }
    return url
}
