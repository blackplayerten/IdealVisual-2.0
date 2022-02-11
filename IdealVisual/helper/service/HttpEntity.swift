//
//  HttpEntity.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 10.12.2021.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPCodes: Int {
    case ok = 200
    case noData = 204
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case alreadyExists = 409
    case unprocessableEntity = 422
}

enum HTTPHeaders: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
}

enum Authorization: String {
    case bearerToken = "Bearer "

    static func getBearerToken(token: String) -> String {
        bearerToken.rawValue + token
    }
}

struct MimeTypes {
    static let defaultMimeType = "application/octet-stream"
    static let appJSON = "application/json"
    static let mimeTypes = [
        "jpeg": "image/jpeg",
        "jpg": "image/jpeg",
        "png": "image/png"
    ]

    static func getFromExtension(ext: String) -> String {
        guard let mimeType = mimeTypes[ext] else {
            return defaultMimeType
        }

        return mimeType
    }
}

struct MultipartFormData {
    static func createBody(parameters: [String: String],
                           boundary: String,
                           data: Data,
                           mimeType: String,
                           filename: String) -> Data {
        let body = NSMutableData()

        let boundaryPrefix = "--\(boundary)\r\n"

        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }

        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))

        return body as Data
    }

    static func getContentTypeValue(boundary: String) -> String {
        return "multipart/form-data; boundary=\(boundary)"
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: .utf8, allowLossyConversion: false)
        append(data!)
    }
}
