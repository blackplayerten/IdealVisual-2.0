//
//  AppLoaderViewModel.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

protocol LaunchViewModelProtocol: AnyObject { }

protocol LaunchViewModelInput: AnyObject {
    func setWarningType(_ type: ConnectionWarningType)
    func configureWarning()
}

protocol LaunchViewModelOutput: AnyObject {
    var alertUpdatedMessage: String { get }
    var bindAlertMessage: (() -> ()) { get set }
}

final class LaunchViewModel: LaunchViewModelProtocol, LaunchViewModelInput, LaunchViewModelOutput {
    // MARK: - vars
    var bindAlertMessage: (() -> ()) = {}

    private(set) var alertUpdatedMessage: String = AppLoaderStrings.alert.localized {
        didSet {
            self.bindAlertMessage()
        }
    }

    // MARK: - func
    func setWarningType(_ type: ConnectionWarningType) {
        warningType = type
    }

    func configureWarning() {
        switch warningType {
        case .connection:
            alertUpdatedMessage = ErrorStrings.access.localized
        case .unavaliable:
            alertUpdatedMessage = ErrorStrings.unavaliable.localized
        }
    }
}

extension LaunchViewModel: LaunchViewOutput {
    var warningType: ConnectionWarningType {
        get { .connection }
        set { }
    }
}
