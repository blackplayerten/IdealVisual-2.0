//
//  AppLoaderModelService.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import Foundation

protocol AppLoaderModelServiceProtocol: AnyObject {
    func launch(completion: @escaping (Result<AppLoaderModel, ServiceErrors>) -> Void)
}

final class AppLoaderModelService: AppLoaderModelServiceProtocol {
    func launch(completion: @escaping (Result<AppLoaderModel, ServiceErrors>) -> Void) {
        // go to back and fetch launh data
        completion(.failure(.noData))
//        completion(.success(AppLoaderModel(isFirstLaunch: false, isUserSignedIn: false)))
    }
}
