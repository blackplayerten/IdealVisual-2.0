//
//  AppLoaderViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import UIKit
import SnapKit

class AppLoaderViewController: UIViewController {
    //MARK: - constants
    private struct UIConstants {
        static let leftRightMargin: Float = 10.0
        static let sizeLoadingIndicator: CGSize = .init(width: 50.0, height: 50.0)
    }
    //MARK: - ui elements
    private var alert: UIAlertController?
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = AppTheme.shared.colorsComponents.background
        indicator.hidesWhenStopped = true
        return indicator
    }()

    //MARK: - data
    private var appLoaderViewModel: AppLoaderViewModelProtocol? {
        didSet {
            bindViewModel()
        }
    }

    // //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        appLoaderViewModel = AppLoaderViewModel()
        configureAlert()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let alert = alert else { return Logger.log("no app loader alert") }
        present(alert, animated: true) { [weak self] in
            DispatchQueue.main.async {
                guard let self = self,
                      let viewModel = self.appLoaderViewModel
                else { return Logger.log("nill self or no view model") }
                viewModel.launchApp()
            }
        }
    }
    
    //MARK: - private func
    private func bindViewModel() {
        guard let viewModel = appLoaderViewModel else { return Logger.log("no view model") }
        viewModel.bindLaunchData = { self.showFirstScreen() }
        viewModel.bindAlertMessage = { self.updateAlertMessage() }
    }

    private func configureAlert() {
        guard let viewModel = appLoaderViewModel else { return Logger.log("no view model") }
        let alert = UIAlertController(title: nil, message: viewModel.alertUpdatedMessage, preferredStyle: .alert)

        alert.view.backgroundColor = .white
        alert.view.layer.backgroundColor = UIColor.white.cgColor
        alert.view.layer.cornerRadius = 20.0
        alert.view.layer.masksToBounds = true
        alert.setValue(NSMutableAttributedString(string: alert.message ?? "", attributes: [NSAttributedString.Key.font: UIFont(name: UIFont.Names.system, size: UIFont.Sizes.small)!]), forKey: "attributedMessage")

        alert.view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints {
            $0.left.equalTo(alert.view).inset(UIConstants.leftRightMargin)
            $0.centerY.equalTo(alert.view)
        }
        loadingIndicator.startAnimating()

        self.alert = alert
    }

    private func updateAlertMessage() {
        guard let viewModel = appLoaderViewModel else { return Logger.log("no view model") }
        guard let alert = alert else { return Logger.log("no app loader alert") }
        alert.message = viewModel.alertUpdatedMessage
        loadingIndicator.stopAnimating()
    }

    private func showFirstScreen() {
        guard let viewModel = appLoaderViewModel else { return Logger.log("no view model") }
        var rootViewController: UIViewController
        if let data = viewModel.launchData {
            data.isFirstLaunch ? (rootViewController = SignUpViewController()) :
            data.isUserSignedIn ? (rootViewController = TabBar()) : (rootViewController = SignInViewController())
        } else {
            updateAlertMessage()
            guard let alert = alert else { return Logger.log("no app loader alert") }
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { _ in exit(-1) }))
            rootViewController = self
        }
        loadingIndicator.stopAnimating()
        guard let window = view.window else { return Logger.log("no window") }
        window.rootViewController = rootViewController
    }
}

