//
//  AppLoaderViewModel.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

final class LaunchViewModel: LaunchViewModelProtocol, LaunchViewModelInput, LaunchViewModelOutput, LaunchViewOutput {
    // MARK: - vars
    var bindAlertMessage: (() -> Void) = {}

    private(set) var alertUpdatedMessage: String = AppStrings.load.localized {
        didSet {
            self.bindAlertMessage()
        }
    }

    func configureWarning(type: ConnectionWarningType) {
        switch type {
        case .connection:
            alertUpdatedMessage = ErrorStrings.access.localized
        case .unavailable:
            alertUpdatedMessage = ErrorStrings.unavailable.localized
        }
    }
}
