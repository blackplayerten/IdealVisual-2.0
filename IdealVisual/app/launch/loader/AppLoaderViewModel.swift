//
//  AppLoaderViewModel.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

protocol AppLoaderViewModelProtocol: AnyObject {
    var bindLaunchData: (() -> ()) { get set }
    var bindAlertMessage: (() -> ()) { get set }
    var launchData: AppLoaderModel? { get }
    var alertUpdatedMessage: String { get }

    func launchApp()
}

final class AppLoaderViewModel: AppLoaderViewModelProtocol {
    // MARK: - vars
    var bindLaunchData: (() -> ()) = {}
    var bindAlertMessage: (() -> ()) = {}

    fileprivate var appLoaderServise: AppLoaderModelServiceProtocol

    private(set) var launchData: AppLoaderModel? {
        didSet {
            self.bindLaunchData()
        }
    }

    private(set) var alertUpdatedMessage: String = AppLoaderStrings.alert.localized {
        didSet {
            self.bindAlertMessage()
        }
    }

    init() {
        self.appLoaderServise = AppLoaderModelService()
    }

    // MARK: - func
    func launchApp() {
        appLoaderServise.launch { [weak self] result in
            guard let self = self else { return Logger.log("nill self") }
            switch result {
            case .success(let data):
                self.alertUpdatedMessage = AppLoaderStrings.alert.localized
                self.launchData = data
            case .failure(let error):
                Logger.log("\(error.localizedDescription)")
                self.alertUpdatedMessage = matchingErrors(error: error)
                self.launchData = nil
            }
        }
    }
}
