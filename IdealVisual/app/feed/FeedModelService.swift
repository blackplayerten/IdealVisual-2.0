//
//  FeedModelService.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 02.02.2022.
//

import Foundation
import PromiseKit

protocol FeedModelServiceProtocol: AnyObject {
    func getPhotosPaths() -> Promise<[String]>
    func getPhotosData(with paths: [String]) -> Promise<[Data]>
}

final class FeedModelService: FeedModelServiceProtocol {
    func getPhotosPaths() -> Promise<[String]> {
        return Promise<[String]> { seal in
            seal.fulfill(["path1", "path2"])
        }
    }

    func getPhotosData(with paths: [String]) -> Promise<[Data]> {
        return Promise<[Data]> { seal in
            seal.fulfill([Data(), Data()])
        }
    }
}
